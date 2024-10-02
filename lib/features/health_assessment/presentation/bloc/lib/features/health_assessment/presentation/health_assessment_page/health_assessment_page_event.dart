import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:wellwave_frontend/features/health_assessment/data/models/health_assessment_health_data_request_model.dart';

abstract class HealthAssessmentPageEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class StepContinue extends HealthAssessmentPageEvent {}

class StepBack extends HealthAssessmentPageEvent {}

class ImagePicked extends HealthAssessmentPageEvent {
  final File imageFile;

  ImagePicked(this.imageFile);

  @override
  List<Object> get props => [imageFile];
}

class UpdateField extends HealthAssessmentPageEvent {
  final String fieldName;
  final dynamic value;

  UpdateField(this.fieldName, this.value);

  @override
  List<Object?> get props => [fieldName, value];
}

class ShowRecommendEvent extends HealthAssessmentPageEvent {}

class ShowHealthConnectEvent extends HealthAssessmentPageEvent {
  @override
  List<Object?> get props => [];
}

class ShowFinishEvent extends HealthAssessmentPageEvent {}

class NavigateToStartHealthStepState extends HealthAssessmentPageEvent {}

class UpdateRiskScoreEvent {
  final String scoreType;
  final int scoreToAdd;

  UpdateRiskScoreEvent(this.scoreType, this.scoreToAdd);
}
