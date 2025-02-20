import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wellwave_frontend/features/health_assessment/data/repositories/health_assessment_repository.dart';
import 'package:wellwave_frontend/features/home/data/repositories/home_repository.dart';
import 'package:wellwave_frontend/features/home/presentation/bloc/home_event.dart';
import 'package:wellwave_frontend/features/home/presentation/bloc/home_state.dart';
import 'package:wellwave_frontend/features/profile/data/repositories/profile_repositories.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final DateTime currentDate;
  final HealthAssessmentRepository healthAssessmentRepository;
  final ProfileRepositories profileRepository;
  final NotificationsRepository notificationsRepository;
  final LoginStreakRepository loginStreakRepository;
  final HealthDataRepository healthDataRepository;
  final Map<String, Map<DateTime, bool>> completionStatus = {};
  List<int> weeklyAverages = [];
  List<String> readNotifications = [];

  HomeBloc(
      {required this.currentDate,
      required this.healthAssessmentRepository,
      required this.loginStreakRepository,
      required this.notificationsRepository,
      required this.profileRepository,
      required this.healthDataRepository})
      : super(HomeState(
          homeStep: 0,
        )) {
    on<FetchHomeEvent>((event, emit) async {
      debugPrint("FetchHomeEvent called");

      emit(HomeLoading(homeStep: 0));

      try {
        final profile = await profileRepository.getUSer();
        final healthData = await healthAssessmentRepository.fetchHealthData();
        final loginStreak = await loginStreakRepository.fetchLoginStreakData();
        final notiData = await notificationsRepository.fetchNotiData();
        final healthStepAndExData =
            await healthDataRepository.fetchStepAndExTimeData();

        print("Fetched Profile: $profile");

        emit(HomeLoadedState(
          step: 0,
          profile: profile,
          healthData: healthData,
          loginStreak: loginStreak,
          notiData: notiData,
          healthStepAndExData: healthStepAndExData,
        ));
      } catch (e) {
        debugPrint("Error fetching home data: $e");

        emit(HomeError(
          message: e.toString(),
          homeStep: 0,
        ));
      }
    });

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

    on<SubmitWeightDataEvent>((event, emit) async {
      final model = event.model;
      final weight = model.weight;

      debugPrint('Sending weight: $weight');

      final success = await profileRepository.updateWeight(weight);

      if (success) {
        debugPrint('Health data updated successfully');

        final updatedProfile = await profileRepository.getUSer();
        final updatedHealthData =
            await healthAssessmentRepository.fetchHealthData();
        final updatedLoginStreak =
            await loginStreakRepository.fetchLoginStreakData();

        emit(HomeLoadedState(
          step: (state as HomeLoadedState).homeStep,
          profile: updatedProfile,
          healthData: updatedHealthData,
          loginStreak: updatedLoginStreak,
        ));
      } else {
        debugPrint('Failed to update health data');
        emit(state);
      }
    });

    on<SubmitHealthDataEvent>((event, emit) async {
      final model = event.model;
      final diastolicBloodPressure = model.diastolicBloodPressure;
      final systolicBloodPressure = model.systolicBloodPressure;
      final hdl = model.hdl;
      final ldl = model.ldl;
      final waistLine = model.waistLine;

      final Map<String, dynamic> updatedHealthData = {};
      if (diastolicBloodPressure != null) {
        updatedHealthData['DIASTOLIC_BLOOD_PRESSURE'] = diastolicBloodPressure;
      }
      if (systolicBloodPressure != null) {
        updatedHealthData['SYSTOLIC_BLOOD_PRESSURE'] = systolicBloodPressure;
      }
      if (hdl != null) {
        updatedHealthData['HDL'] = hdl;
      }
      if (ldl != null) {
        updatedHealthData['LDL'] = ldl;
      }
      if (waistLine != null) {
        updatedHealthData['WAIST_LINE'] = waistLine;
      }

      final success =
          await healthAssessmentRepository.updateHealthData(updatedHealthData);

      if (success) {
        debugPrint('Health data updated successfully');

        final updatedProfile = await profileRepository.getUSer();
        final updatedHealth =
            await healthAssessmentRepository.fetchHealthData();
        final updatedLoginStreak =
            await loginStreakRepository.fetchLoginStreakData();

        emit(HomeLoadedState(
          step: (state as HomeLoadedState).homeStep,
          profile: updatedProfile,
          healthData: updatedHealth,
          loginStreak: updatedLoginStreak,
        ));
      } else {
        debugPrint('Failed to update health data');
        emit(state);
      }
    });

    on<MarkAsReadNotiEvent>(_onMarkAsReadNotiEvent);
    on<MarkAllAsReadNotiEvent>(_onMarkAllAsReadNotiEvent);
  }
  Future<void> _onMarkAsReadNotiEvent(
    MarkAsReadNotiEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      final success = await notificationsRepository.markAsReadNotification(
        notificationId: event.notificationId,
      );

      if (success) {
        if (state is HomeLoadedState) {
          final currentState = state as HomeLoadedState;
          final updatedNotifications =
              currentState.notiData!.map((notification) {
            if (notification.notificationId == event.notificationId) {
              return notification.copyWith(isRead: true);
            }
            return notification;
          }).toList();

          emit(currentState.copyWith(notiData: updatedNotifications));
        }
      } else {
        debugPrint('Failed to mark as read');
      }
    } catch (e) {
      debugPrint('Failed to mark as read: $e');
    }
  }

  Future<void> _onMarkAllAsReadNotiEvent(
    MarkAllAsReadNotiEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      final success = await notificationsRepository.markAllAsReadNotification();

      if (success) {
        if (state is HomeLoadedState) {
          final currentState = state as HomeLoadedState;
          final updatedNotifications =
              currentState.notiData!.map((notification) {
            return notification.copyWith(isRead: true);
          }).toList();

          emit(currentState.copyWith(notiData: updatedNotifications));
        }
      } else {
        debugPrint('Failed to mark as read');
      }
    } catch (e) {
      debugPrint('Failed to mark as read: $e');
    }
  }
}
// Future<void> _onLoadNotifications(
//   LoadNotificationsEvent event,
//   Emitter<HomeState> emit,
// ) async {
//   final prefs = await SharedPreferences.getInstance();
//   final readNotifications = prefs.getStringList('read_notifications') ?? [];

//   final latestNotifications = notificationlist.reversed.take(7).toList();

//   bool hasNewNotification = latestNotifications.any(
//     (notification) => !readNotifications.contains(notification.id.toString()),
//   );

//   if (state is HomeLoadedState) {
//     final currentState = state as HomeLoadedState;
//     emit(currentState.copyWith(
//       readNotifications: readNotifications,
//       hasNewNotification: hasNewNotification,
//     ));
//   }
// }

// Future<void> _onMarkNotificationAsRead(
//     MarkNotificationAsReadEvent event, Emitter<HomeState> emit) async {
//   final prefs = await SharedPreferences.getInstance();
//   final currentState = state as HomeLoadedState;
//   final readNotifications = List<String>.from(currentState.readNotifications);

//   if (!readNotifications.contains(event.notificationId.toString())) {
//     readNotifications.add(event.notificationId.toString());
//     await prefs.setStringList('read_notifications', readNotifications);

//     bool hasNewNotification = notificationlist.any(
//       (notification) =>
//           !readNotifications.contains(notification.id.toString()),
//     );

//     emit(currentState.copyWith(
//       readNotifications: readNotifications,
//       hasNewNotification: hasNewNotification,
//     ));
//   }
// }

// void _onNewNotificationReceived(
//     NewNotificationReceived event, Emitter<HomeState> emit) {
//   if (state is HomeLoadedState) {
//     final currentState = state as HomeLoadedState;
//     notificationlist.add(event.notification);
//     emit(currentState.copyWith(hasNewNotification: true));
//   }
// }

// void _onUpdateHealthData(
//     UpdateDataFromReAssessmentEvent event, Emitter<HomeState> emit) {
//   weeklyAverages = calculateWeeklyAverages(event.newData);
//   if (state is HomeLoadedState) {
//     emit((state as HomeLoadedState).copyWith(
//       weeklyAverages: weeklyAverages,
//     ));
//   }
// }
