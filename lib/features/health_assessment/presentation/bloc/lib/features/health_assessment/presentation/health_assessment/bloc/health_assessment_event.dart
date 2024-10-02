part of 'health_assessment_bloc.dart';

abstract class HealthAssessmentEvent {}

// class SubmitHealthDataEvent extends HealthAssessmentEvent {
//   final HealthAssessmentHealthDataRequestModel model;

//   SubmitHealthDataEvent(this.model);
// }

class SubmitPersonalDataEvent extends HealthAssessmentEvent {
  final HealthAssessmentPersonalDataRequestModel model;

  SubmitPersonalDataEvent(this.model);
}
