import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wellwave_frontend/features/health_assessment/data/models/health_assessment_health_data_request_model.dart';
import 'package:wellwave_frontend/features/health_assessment/data/models/health_assessment_personal_data_request_model.dart';
import 'package:wellwave_frontend/features/health_assessment/data/repositories/health_assessment_repository.dart';
import 'package:wellwave_frontend/features/home/data/models/notification.dart';
import 'package:wellwave_frontend/features/home/data/repositories/home_repository.dart';
import 'package:wellwave_frontend/features/home/presentation/bloc/home_event.dart';
import 'package:wellwave_frontend/features/home/presentation/bloc/home_state.dart';
import 'package:wellwave_frontend/features/home/widget/mockup_data/notification_data.dart';
import 'package:wellwave_frontend/features/profile/data/repositories/profile_repositories.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final DateTime currentDate;
  final HealthAssessmentRepository healthAssessmentRepository;
  final ProfileRepositories profileRepositories;
  final LoginStreakRepository loginStreakRepository;
  final Map<String, Map<DateTime, bool>> completionStatus = {};
  List<int> weeklyAverages = [];
  List<String> readNotifications = [];
  final List<Notifications> notificationlist = getMockNotificationData();

  HomeBloc({
    required this.currentDate,
    required this.healthAssessmentRepository,
    required this.loginStreakRepository,
    required this.profileRepositories,
  }) : super(HomeState(
          homeStep: 0,
        )) {
    on<LoadNotificationsEvent>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      final readNotifications = prefs.getStringList('read_notifications') ?? [];
      if (state is HomeLoadedState) {
        final currentState = state as HomeLoadedState;
        bool hasNewNotification = notificationlist.any(
          (notification) =>
              !readNotifications.contains(notification.id.toString()),
        );
        emit(currentState.copyWith(
          readNotifications: readNotifications,
          hasNewNotification: hasNewNotification,
        ));
      } else {
        emit(HomeLoadedState(
          step: 0,
          readNotifications: readNotifications,
          hasNewNotification: notificationlist.isNotEmpty,
          weeklyAverages: weeklyAverages,
          exp: 0,
          gem: 0,
          userGoalStepWeek: 0,
          userGoalExTimeWeek: 0,
          username: '',
          imageUrl: '',
          currentStreak: 0,
          hdl: 0,
          ldl: 0,
          weight: 0,
          waistLine: 0,
          systolicBloodPressure: 0,
          diastolicBloodPressure: 0,
        ));
      }
    });

    on<MarkNotificationAsReadEvent>(_onMarkNotificationAsRead);
    // on<UpdateDataFromReAssessmentEvent>(_onUpdateHealthData);
    on<NewNotificationReceived>(_onNewNotificationReceived);
    on<SetHasNewNotificationFalseEvent>((event, emit) {
      if (state is HomeLoadedState) {
        final currentState = state as HomeLoadedState;
        final newState = currentState.copyWith(hasNewNotification: false);
        emit(newState);
      }
    });

    on<FetchData>(_onFetchData);
    add(LoadNotificationsEvent());
    add(FetchData());
    on<NextStep>((event, emit) {
      if (state.homeStep < 3) {
        emit(state.copyWith(step: state.homeStep + 1));
      }
    });
    on<PreviousStep>((event, emit) {
      if (state.homeStep > 0) {
        emit(state.copyWith(step: state.homeStep - 1));
      }
    });
    on<ResetStep>((event, emit) {
      emit(state.copyWith(step: 0, formDataReassessment: {}));
    });
    on<UpdateFieldData>((event, emit) {
      final currentState = state;
      if (currentState is HomeLoadedState) {
        final updatedFormData =
            Map<String, dynamic>.from(currentState.formDataReassessment ?? {});
        updatedFormData[event.fieldName] = event.value;

        emit(currentState.copyWith(formDataReassessment: updatedFormData));
      }
    });

    on<SubmitReAssessmentDataEvent>((event, emit) async {
      final model = event.model;
      final weight = model.weight;

      debugPrint('Sending weight: $weight');

      final success = await profileRepositories.updateWeight(weight);

      if (success) {
        debugPrint('Health data updated successfully');
        emit((state as HomeLoadedState).copyWith(weight: model.weight));
      } else {
        debugPrint('Failed to update health data');
        emit(state);
      }
    });
  }

  Future<void> _onLoadNotifications(
    LoadNotificationsEvent event,
    Emitter<HomeState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final readNotifications = prefs.getStringList('read_notifications') ?? [];

    final latestNotifications = notificationlist.reversed.take(7).toList();

    bool hasNewNotification = latestNotifications.any(
      (notification) => !readNotifications.contains(notification.id.toString()),
    );

    if (state is HomeLoadedState) {
      final currentState = state as HomeLoadedState;
      emit(currentState.copyWith(
        readNotifications: readNotifications,
        hasNewNotification: hasNewNotification,
      ));
    }
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

  Future<void> _onFetchData(
    FetchData event,
    Emitter<HomeState> emit,
  ) async {
    try {
      final assessmentData =
          await healthAssessmentRepository.fetchPersonaData();
      final loginStreakData =
          await loginStreakRepository.fetchLoginStreakData();
      final reassessmentData =
          await healthAssessmentRepository.fetchHealthData();

      final int currentStreak = loginStreakData['currentStreak'] ?? 0;
      final int exp = assessmentData['exp'] ?? 0;
      final int gem = assessmentData['gem'] ?? 0;
      final int userGoalStepWeek = assessmentData['userGoalStepWeek'] ?? 0;
      final int userGoalExTimeWeek = assessmentData['userGoalExTimeWeek'] ?? 0;
      final String imageUrl = assessmentData['imageUrl'] ?? '';
      final String username = assessmentData['username'] ?? '';
      final double diastolicBloodPressure =
          reassessmentData['diastolicBloodPressure'] ?? 0;
      final double systolicBloodPressure =
          reassessmentData['systolicBloodPressure'] ?? 0.0;
      final double hdl = reassessmentData['hdl'] ?? 0.0;
      final double ldl = reassessmentData['ldl'] ?? 0.0;
      final double waistLine = reassessmentData['waistLine'] ?? 0.0;
      final double weight = reassessmentData['weight'] ?? 0.0;

      debugPrint(
          'weight = $weight, diastolicBloodPressure= $diastolicBloodPressure, systolicBloodPressure= $systolicBloodPressure, hdl= $hdl, ldl= $ldl, waistLine= $waistLine');

      if (state is HomeLoadedState) {
        final currentState = state as HomeLoadedState;
        emit(currentState.copyWith(
          exp: exp,
          gem: gem,
          userGoalStepWeek: userGoalStepWeek,
          userGoalExTimeWeek: userGoalExTimeWeek,
          username: username,
          currentStreak: currentStreak,
          imageUrl: imageUrl,
          diastolicBloodPressure: diastolicBloodPressure,
          systolicBloodPressure: systolicBloodPressure,
          hdl: hdl,
          ldl: ldl,
          waistLine: waistLine,
          weight: weight,
        ));
      }
    } catch (e) {
      debugPrint('Error loading data: $e');
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

  // void _onUpdateHealthData(
  //     UpdateDataFromReAssessmentEvent event, Emitter<HomeState> emit) {
  //   weeklyAverages = calculateWeeklyAverages(event.newData);
  //   if (state is HomeLoadedState) {
  //     emit((state as HomeLoadedState).copyWith(
  //       weeklyAverages: weeklyAverages,
  //     ));
  //   }
  // }

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
