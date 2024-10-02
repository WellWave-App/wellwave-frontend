part of 'health_assessment_bloc.dart';

sealed class HealthAssessmentState extends Equatable {
  const HealthAssessmentState();

  @override
  List<Object> get props => [];
}

final class HealthAssessmentInitial extends HealthAssessmentState {}

class HealthAssessmentLoading extends HealthAssessmentState {}

class HealthAssessmentSuccess extends HealthAssessmentState {
  const HealthAssessmentSuccess();
}

class HealthAssessmentFail extends HealthAssessmentState {
  final String message;

  HealthAssessmentFail(this.message);
}
