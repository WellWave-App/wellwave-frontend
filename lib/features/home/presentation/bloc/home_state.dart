import 'package:flutter/material.dart';
import 'package:wellwave_frontend/features/health_assessment/data/models/health_assessment_health_data_request_model.dart';
import 'package:wellwave_frontend/features/home/data/models/health_data_step_and_ex_respone_model.dart';
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
  final HealthDataStepAndExResponeModel? healthStepAndExData;

  const HomeLoadedState({
    required int step,
    this.profile,
    this.healthData,
    this.loginStreak,
    this.notiData,
    this.healthStepAndExData,
    Map<String, dynamic>? formDataReassessment,
  }) : super(homeStep: step, formDataReassessment: formDataReassessment);

  HomeLoadedState copyWith({
    int? step,
    ProfileRequestModel? profile,
    HealthAssessmentHealthDataRequestModel? healthData,
    LoginStreakDataResponseModel? loginStreak,
    HealthDataStepAndExResponeModel? healthStepAndExData,
    List<NotificationsDataResponseModel>? notiData,
    Map<String, dynamic>? formDataReassessment,
  }) {
    return HomeLoadedState(
      step: step ?? homeStep,
      profile: profile ?? this.profile,
      healthData: healthData ?? this.healthData,
      loginStreak: loginStreak ?? this.loginStreak,
      notiData: notiData ?? this.notiData,
      healthStepAndExData: healthStepAndExData ?? this.healthStepAndExData,
      formDataReassessment: formDataReassessment ?? this.formDataReassessment,
    );
  }

  @override
  List<Object?> get props => super.props
    ..addAll([profile, healthData, loginStreak, notiData, healthStepAndExData]);
}
