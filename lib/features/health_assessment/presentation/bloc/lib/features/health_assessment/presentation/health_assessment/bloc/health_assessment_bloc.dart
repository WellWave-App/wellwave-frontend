import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'health_assessment_event.dart';
part 'health_assessment_state.dart';

class HealthAssessmentBloc
    extends Bloc<HealthAssessmentEvent, HealthAssessmentState> {
  HealthAssessmentBloc() : super(HealthAssessmentInitial()) {
    on<HealthAssessmentEvent>((event, emit) {});
  }
}
