part of 'health_assessment_bloc.dart';

sealed class HealthAssessmentState extends Equatable {
  const HealthAssessmentState();

  @override
  List<Object> get props => [];
}

final class HealthAssessmentInitial extends HealthAssessmentState {}

class LeaveRequestLoading extends HealthAssessmentState {}

class LeaveRequestSuccess extends HealthAssessmentState {
  const LeaveRequestSuccess();
}

class LeaveRequestFail extends HealthAssessmentState {
  final String message;

  const LeaveRequestFail({
    required this.message,
  });
}
