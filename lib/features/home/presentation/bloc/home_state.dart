import 'package:flutter/material.dart';
import 'package:wellwave_frontend/features/health_assessment/data/models/health_assessment_health_data_request_model.dart';
import 'package:wellwave_frontend/features/home/data/models/login_streak_data_respone_model.dart';
import 'package:wellwave_frontend/features/home/data/models/notifications_data_respone_model.dart';
import 'package:wellwave_frontend/features/profile/data/models/profile_request_model.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class HomeState extends Equatable {
  final int homeStep;
  final Map<String, dynamic>? formDataReassessment;

  const HomeState({required this.homeStep, this.formDataReassessment});

  HomeState copyWith({int? step, Map<String, dynamic>? formDataReassessment}) {
    return HomeState(
      homeStep: step ?? homeStep,
      formDataReassessment: formDataReassessment ?? this.formDataReassessment,
    );
  }

  @override
  List<Object?> get props => [homeStep, formDataReassessment];
}

class HomeLoading extends HomeState {
  const HomeLoading({required int homeStep}) : super(homeStep: homeStep);
}

class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message, required int homeStep})
      : super(homeStep: homeStep);

  @override
  List<Object?> get props => super.props..add(message);
}

class HomeLoadedState extends HomeState {
  final ProfileRequestModel? profile;
  final HealthAssessmentHealthDataRequestModel? healthData;
  final LoginStreakDataResponseModel? loginStreak;
  final List<NotificationsDataResponseModel>? notiData;

  const HomeLoadedState({
    required int step,
    this.profile,
    this.healthData,
    this.loginStreak,
    this.notiData,
    Map<String, dynamic>? formDataReassessment,
  }) : super(homeStep: step, formDataReassessment: formDataReassessment);

  HomeLoadedState copyWith({
    int? step,
    ProfileRequestModel? profile,
    HealthAssessmentHealthDataRequestModel? healthData,
    LoginStreakDataResponseModel? loginStreak,
    List<NotificationsDataResponseModel>? notiData,
    Map<String, dynamic>? formDataReassessment,
  }) {
    return HomeLoadedState(
      step: step ?? homeStep,
      profile: profile ?? this.profile,
      healthData: healthData ?? this.healthData,
      loginStreak: loginStreak ?? this.loginStreak,
      notiData: notiData ?? this.notiData,
      formDataReassessment: formDataReassessment ?? this.formDataReassessment,
    );
  }

  @override
  List<Object?> get props =>
      super.props..addAll([profile, healthData, loginStreak, notiData]);
}


// class HealthDataUpdatedState extends HomeState {
//   final String message;

//   HealthDataUpdatedState(
//       {this.message = 'Health data updated successfully',
//       required super.homeStep});

//   @override
//   List<Object> get props => [message];
// }

// class HealthDataUpdateFailedState extends HomeState {
//   final String errorMessage;

//   HealthDataUpdateFailedState(
//       {this.errorMessage = 'Failed to update health data',
//       required super.homeStep});

//   @override
//   List<Object> get props => [errorMessage];
// }



// class HomeLoadedState extends HomeState {
//   final int exp;
//   final int gem;
//   final String imageUrl;
//   final String username;
//   final int userGoalStepWeek;
//   final int userGoalExTimeWeek;
//   final List<int> weeklyAverages;
//   final List<String> readNotifications;
//   final bool hasNewNotification;
//   final int currentStreak;
//   final double? weight;
//   final double? diastolicBloodPressure;
//   final double? systolicBloodPressure;
//   final double? hdl;
//   final double? ldl;
//   final double? waistLine;
//   final Map<String, dynamic>? formDataReassessment;

//   HomeLoadedState({
//     required this.exp,
//     required this.gem,
//     required this.imageUrl,
//     required this.username,
//     required this.userGoalStepWeek,
//     required this.userGoalExTimeWeek,
//     required this.weeklyAverages,
//     required this.readNotifications,
//     required this.hasNewNotification,
//     required this.currentStreak,
//     required int step,
//     this.diastolicBloodPressure,
//     this.hdl,
//     this.ldl,
//     this.systolicBloodPressure,
//     this.waistLine,
//     this.weight,
//     this.formDataReassessment,
//   }) : super(homeStep: step);

//   HomeLoadedState copyWith({
//     int? step,
//     int? exp,
//     int? gem,
//     String? imageUrl,
//     String? username,
//     int? userGoalStepWeek,
//     int? userGoalExTimeWeek,
//     List<int>? weeklyAverages,
//     List<String>? readNotifications,
//     bool? hasNewNotification,
//     int? currentStreak,
//     double? weight,
//     double? diastolicBloodPressure,
//     double? systolicBloodPressure,
//     double? hdl,
//     double? ldl,
//     double? waistLine,
//     Map<String, dynamic>? formDataReassessment,
//   }) {
//     return HomeLoadedState(
//       step: step ?? this.homeStep,
//       exp: exp ?? this.exp,
//       gem: gem ?? this.gem,
//       imageUrl: imageUrl ?? this.imageUrl,
//       username: username ?? this.username,
//       userGoalStepWeek: userGoalStepWeek ?? this.userGoalStepWeek,
//       userGoalExTimeWeek: userGoalExTimeWeek ?? this.userGoalExTimeWeek,
//       weeklyAverages: weeklyAverages ?? this.weeklyAverages,
//       readNotifications: readNotifications ?? this.readNotifications,
//       hasNewNotification: hasNewNotification ?? this.hasNewNotification,
//       currentStreak: currentStreak ?? this.currentStreak,
//       weight: weight ?? this.weight,
//       diastolicBloodPressure:
//           diastolicBloodPressure ?? this.diastolicBloodPressure,
//       systolicBloodPressure:
//           systolicBloodPressure ?? this.systolicBloodPressure,
//       hdl: hdl ?? this.hdl,
//       ldl: ldl ?? this.ldl,
//       waistLine: waistLine ?? this.waistLine,
//       formDataReassessment: formDataReassessment ?? this.formDataReassessment,
//     );
//   }
// }