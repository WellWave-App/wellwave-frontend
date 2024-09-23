import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class AssessmentEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class StepContinue extends AssessmentEvent {}

class StepBack extends AssessmentEvent {}

class ImagePicked extends AssessmentEvent {
  final File image;

  ImagePicked(this.image);

  @override
  List<Object?> get props => [image];
}

class UpdateField extends AssessmentEvent {
  final String fieldName;
  final String value;

  UpdateField(this.fieldName, this.value);

  @override
  List<Object?> get props => [fieldName, value];
}

class ShowRecommendEvent extends AssessmentEvent {}

class ShowHealthConnectEvent extends AssessmentEvent {}

class ShowFinishEvent extends AssessmentEvent {}

class NavigateToStartHealthStepState extends AssessmentEvent {}

class UpdateRiskScoreEvent {
  final String scoreType;
  final int scoreToAdd;

  UpdateRiskScoreEvent(this.scoreType, this.scoreToAdd);
}
