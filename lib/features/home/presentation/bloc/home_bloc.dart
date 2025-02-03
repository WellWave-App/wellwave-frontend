import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final DateTime currentDate;
  final Map<String, Map<DateTime, bool>> completionStatus = {};
  List<int> weeklyAverages = [];
  List<String> readNotifications = [];

  HomeBloc({required this.currentDate}) : super(HomeInitial()) {
    on<LoadNotificationsEvent>(_onLoadNotifications);
    on<MarkNotificationAsReadEvent>(_onMarkNotificationAsRead);
    on<UpdateHealthDataEvent>(_onUpdateHealthData);
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    final prefs = await SharedPreferences.getInstance();
    final loadedReadNotifications =
        prefs.getStringList('read_notifications') ?? [];
    readNotifications = loadedReadNotifications;

    emit(HomeLoadedState(
      weeklyAverages: weeklyAverages,
      readNotifications: readNotifications,
    ));
  }

  Future<void> _onLoadNotifications(
      LoadNotificationsEvent, Emitter<HomeState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final readNotifications = prefs.getStringList('read_notifications') ?? [];

    emit((state as HomeLoadedState)
        .copyWith(readNotifications: readNotifications));
  }

  Future<void> _onMarkNotificationAsRead(
      MarkNotificationAsReadEvent event, Emitter<HomeState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final currentState = state as HomeLoadedState;
    final readNotifications = List<String>.from(currentState.readNotifications);

    if (!readNotifications.contains(event.notificationId.toString())) {
      readNotifications.add(event.notificationId.toString());
      await prefs.setStringList('read_notifications', readNotifications);

      this.readNotifications = readNotifications;

      emit(currentState.copyWith(readNotifications: readNotifications));
    }
  }

  void _onUpdateHealthData(
      UpdateHealthDataEvent event, Emitter<HomeState> emit) {
    weeklyAverages = calculateWeeklyAverages(event.newData);
    emit(HomeLoadedState(
        weeklyAverages: weeklyAverages, readNotifications: readNotifications));
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
