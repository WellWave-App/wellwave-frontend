import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:wellwave_frontend/features/health_assessment/data/models/health_assessment_request_model.dart';

abstract class AssessmentEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class StepContinue extends AssessmentEvent {}

class StepBack extends AssessmentEvent {}

class ImagePicked extends AssessmentEvent {
  final File imageFile;

  ImagePicked(this.imageFile);

  @override
  List<Object> get props => [imageFile];
}

class UpdateField extends AssessmentEvent {
  final String fieldName;
  final String value;

  UpdateField(this.fieldName, this.value);

  @override
  List<Object?> get props => [fieldName, value];
}

class ShowRecommendEvent extends AssessmentEvent {}

class ShowHealthConnectEvent extends AssessmentEvent {
  @override
  List<Object?> get props => [];
}

class ShowFinishEvent extends AssessmentEvent {}

class NavigateToStartHealthStepState extends AssessmentEvent {}

class UpdateRiskScoreEvent {
  final String scoreType;
  final int scoreToAdd;

  UpdateRiskScoreEvent(this.scoreType, this.scoreToAdd);
}

class SendHealthAssessmentData extends AssessmentEvent {
  final HealthAssessmentRequestModel requestModel;

  SendHealthAssessmentData(this.requestModel);

  @override
  List<Object> get props => [requestModel];
}
