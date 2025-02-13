import 'package:flutter/material.dart';

@immutable
class HomeState {
  final int homeStep;
  final Map<String, dynamic>? formDataReassessment;

  HomeState({required this.homeStep, this.formDataReassessment});

  HomeState copyWith({int? step, Map<String, dynamic>? formDataReassessment}) {
    return HomeState(
      homeStep: step ?? this.homeStep,
      formDataReassessment: formDataReassessment ?? this.formDataReassessment,
    );
  }

  @override
  List<Object> get props => [homeStep];
}

class HomeLoadedState extends HomeState {
  final int exp;
  final int gem;
  final String imageUrl;
  final String username;
  final int userGoalStepWeek;
  final int userGoalExTimeWeek;
  final List<int> weeklyAverages;
  final List<String> readNotifications;
  final bool hasNewNotification;
  final int currentStreak;
  final double? weight;
  final double? diastolicBloodPressure;
  final double? systolicBloodPressure;
  final double? hdl;
  final double? ldl;
  final double? waistLine;
  final Map<String, dynamic>? formDataReassessment;

  HomeLoadedState({
    required this.exp,
    required this.gem,
    required this.imageUrl,
    required this.username,
    required this.userGoalStepWeek,
    required this.userGoalExTimeWeek,
    required this.weeklyAverages,
    required this.readNotifications,
    required this.hasNewNotification,
    required this.currentStreak,
    required int step,
    this.diastolicBloodPressure,
    this.hdl,
    this.ldl,
    this.systolicBloodPressure,
    this.waistLine,
    this.weight,
    this.formDataReassessment,
  }) : super(homeStep: step);

  HomeLoadedState copyWith({
    int? step,
    int? exp,
    int? gem,
    String? imageUrl,
    String? username,
    int? userGoalStepWeek,
    int? userGoalExTimeWeek,
    List<int>? weeklyAverages,
    List<String>? readNotifications,
    bool? hasNewNotification,
    int? currentStreak,
    double? weight,
    double? diastolicBloodPressure,
    double? systolicBloodPressure,
    double? hdl,
    double? ldl,
    double? waistLine,
    Map<String, dynamic>? formDataReassessment,
  }) {
    return HomeLoadedState(
      step: step ?? this.homeStep,
      exp: exp ?? this.exp,
      gem: gem ?? this.gem,
      imageUrl: imageUrl ?? this.imageUrl,
      username: username ?? this.username,
      userGoalStepWeek: userGoalStepWeek ?? this.userGoalStepWeek,
      userGoalExTimeWeek: userGoalExTimeWeek ?? this.userGoalExTimeWeek,
      weeklyAverages: weeklyAverages ?? this.weeklyAverages,
      readNotifications: readNotifications ?? this.readNotifications,
      hasNewNotification: hasNewNotification ?? this.hasNewNotification,
      currentStreak: currentStreak ?? this.currentStreak,
      weight: weight ?? this.weight,
      diastolicBloodPressure:
          diastolicBloodPressure ?? this.diastolicBloodPressure,
      systolicBloodPressure:
          systolicBloodPressure ?? this.systolicBloodPressure,
      hdl: hdl ?? this.hdl,
      ldl: ldl ?? this.ldl,
      waistLine: waistLine ?? this.waistLine,
      formDataReassessment: formDataReassessment ?? this.formDataReassessment,
    );
  }
}

class HealthDataUpdatedState extends HomeState {
  final String message;

  HealthDataUpdatedState(
      {this.message = 'Health data updated successfully',
      required super.homeStep});

  @override
  List<Object> get props => [message];
}

class HealthDataUpdateFailedState extends HomeState {
  final String errorMessage;

  HealthDataUpdateFailedState(
      {this.errorMessage = 'Failed to update health data',
      required super.homeStep});

  @override
  List<Object> get props => [errorMessage];
}
