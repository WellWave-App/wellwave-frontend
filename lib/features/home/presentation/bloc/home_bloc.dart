import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wellwave_frontend/features/home/data/models/notification.dart';
import 'package:wellwave_frontend/features/home/widget/mockup_data/notification_data.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final DateTime currentDate;
  final Map<String, Map<DateTime, bool>> completionStatus = {};
  List<int> weeklyAverages = [];
  List<String> readNotifications = [];
  final List<Notifications> notificationlist = getMockNotificationData();

  HomeBloc({required this.currentDate}) : super(HomeInitial()) {
    on<LoadNotificationsEvent>(_onLoadNotifications);
    on<MarkNotificationAsReadEvent>(_onMarkNotificationAsRead);
    on<UpdateHealthDataEvent>(_onUpdateHealthData);
    on<NewNotificationReceived>(_onNewNotificationReceived);
    on<SetHasNewNotificationFalseEvent>((event, emit) {
      if (state is HomeLoadedState) {
        final currentState = state as HomeLoadedState;
        final newState = currentState.copyWith(hasNewNotification: false);
        emit(newState);
      }
    });

    add(LoadNotificationsEvent());
  }

  Future<void> _onLoadNotifications(
      LoadNotificationsEvent event, Emitter<HomeState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final readNotifications = prefs.getStringList('read_notifications') ?? [];

    bool hasNewNotification = notificationlist.any(
      (notification) => !readNotifications.contains(notification.id.toString()),
    );

    emit(HomeLoadedState(
      weeklyAverages: weeklyAverages,
      readNotifications: readNotifications,
      hasNewNotification: hasNewNotification,
    ));
  }

  Future<void> _onMarkNotificationAsRead(
      MarkNotificationAsReadEvent event, Emitter<HomeState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final currentState = state as HomeLoadedState;
    final readNotifications = List<String>.from(currentState.readNotifications);

    if (!readNotifications.contains(event.notificationId.toString())) {
      readNotifications.add(event.notificationId.toString());
      await prefs.setStringList('read_notifications', readNotifications);

      bool hasNewNotification = notificationlist.any(
        (notification) =>
            !readNotifications.contains(notification.id.toString()),
      );

      emit(currentState.copyWith(
        readNotifications: readNotifications,
        hasNewNotification: hasNewNotification,
      ));
    }
  }

  void _onNewNotificationReceived(
      NewNotificationReceived event, Emitter<HomeState> emit) {
    if (state is HomeLoadedState) {
      final currentState = state as HomeLoadedState;

      notificationlist.add(event.notification);
      emit(currentState.copyWith(hasNewNotification: true));
    }
  }

  void _onUpdateHealthData(
      UpdateHealthDataEvent event, Emitter<HomeState> emit) {
    weeklyAverages = calculateWeeklyAverages(event.newData);
    if (state is HomeLoadedState) {
      emit((state as HomeLoadedState).copyWith(
        weeklyAverages: weeklyAverages,
      ));
    }
  }

  List<int> calculateWeeklyAverages(List<Map<String, dynamic>> data) {
    List<int> weeklyAverages = [];
    int weekSum = 0;
    int dayCount = 0;

    for (int i = 0; i < data.length; i++) {
      int value = data[i]['value'] as int;
      weekSum += value;
      dayCount++;

      if (dayCount == 7 || i == data.length - 1) {
        int average = (weekSum / dayCount).round();
        weeklyAverages.add(average);
        weekSum = 0;
        dayCount = 0;
      }
    }
    return weeklyAverages;
  }
}
