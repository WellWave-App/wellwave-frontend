part of 'health_assessment_bloc.dart';

abstract class HealthAssessmentEvent {}

class SubmitHealthDataEvent extends HealthAssessmentEvent {
  final HealthAssessmentHealthDataRequestModel modelHealthData;

  SubmitHealthDataEvent(this.modelHealthData);
}

class SubmitPersonalDataEvent extends HealthAssessmentEvent {
  final HealthAssessmentPersonalDataRequestModel modelPersonaData;

  SubmitPersonalDataEvent(this.modelPersonaData);
}
