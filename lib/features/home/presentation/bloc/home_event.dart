import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:wellwave_frontend/features/health_assessment/data/models/health_assessment_personal_data_request_model.dart';
import 'package:wellwave_frontend/features/home/data/models/notification.dart';

@immutable
sealed class HomeEvent {
  @override
  List<Object> get props => [];
}

class UpdateDataFromReAssessmentEvent extends HomeEvent {
  final HealthAssessmentPersonalDataRequestModel model;

  UpdateDataFromReAssessmentEvent(this.model);
}

class CalculateWeeklyAveragesEvent extends HomeEvent {
  final List<Map<String, dynamic>> data;

  CalculateWeeklyAveragesEvent(this.data);
}

class GenerateGreetingTextEvent extends HomeEvent {}

class UpdateCompletionStatusEvent extends HomeEvent {
  final String progressId;
  final DateTime date;
  final bool isComplete;

  UpdateCompletionStatusEvent({
    required this.progressId,
    required this.date,
    required this.isComplete,
  });
}

class LoadNotificationsEvent extends HomeEvent {}

class MarkNotificationAsReadEvent extends HomeEvent {
  final String notificationId;

  MarkNotificationAsReadEvent(this.notificationId);
}

class NewNotificationReceived extends HomeEvent {
  final Notifications notification;

  NewNotificationReceived(this.notification);
}

class SetHasNewNotificationFalseEvent extends HomeEvent {}

class FetchData extends HomeEvent {}

class NextStep extends HomeEvent {}

class PreviousStep extends HomeEvent {}

class ResetStep extends HomeEvent {}

class UpdateFieldData extends HomeEvent {
  final String fieldName;
  final dynamic value;

  UpdateFieldData(this.fieldName, this.value);

  @override
  List<Object> get props => [fieldName, value];
}

class SubmitReAssessmentDataEvent extends HomeEvent {
  final HealthAssessmentPersonalDataRequestModel model;

  SubmitReAssessmentDataEvent(this.model);
  @override
  List<Object> get props => [model];
}
