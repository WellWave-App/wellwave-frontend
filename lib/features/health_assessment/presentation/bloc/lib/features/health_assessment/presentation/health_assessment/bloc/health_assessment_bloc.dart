import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:wellwave_frontend/features/health_assessment/data/models/health_assessment_health_data_request_model.dart';

import 'package:wellwave_frontend/features/health_assessment/data/models/health_assessment_personal_data_request_model.dart';
import 'package:wellwave_frontend/features/health_assessment/data/repositories/health_assessment_repository.dart';

part 'health_assessment_event.dart';
part 'health_assessment_state.dart';

class HealthAssessmentBloc
    extends Bloc<HealthAssessmentEvent, HealthAssessmentState> {
  final HealthAssessmentRepository _repository;

  HealthAssessmentBloc(this._repository) : super(HealthAssessmentInitial()) {
    on<SubmitPersonalDataEvent>((event, emit) async {
      final model = event.model;

      final success = await _repository.sendHealthAssessmentPersonalData(model);

      if (success) {
        debugPrint('Data sent successfully');
      } else {
        debugPrint('Failed to send data');
      }
    });
  }
}
