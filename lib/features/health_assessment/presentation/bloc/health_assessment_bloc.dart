import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:wellwave_frontend/features/health_assessment/presentation/screen/health_assessment_screen.dart';
import 'dart:io';

import 'health_assessment_event.dart';
import 'health_assessment_state.dart';

class ValidateGender extends AssessmentEvent {}

class AssessmentBloc extends Bloc<AssessmentEvent, AssessmentState> {
  AssessmentBloc()
      : super(const AssessmentState(
          currentStep: 0,
          formData: {},
          selectedItems: [],
          isMultiSelect: false,
        )) {
    on<StepBack>((event, emit) {
      if (state.currentStep > 0) {
        emit(state.copyWith(currentStep: state.currentStep - 1));
      }
    });
    on<ImagePicked>(_onImagePicked);
    on<UpdateField>(_onUpdateField);
    on<ValidateGender>(_onValidateGender);
    on<ToggleSelectionEvent>(_onToggleSelection);
    on<SetSelectionMode>(_onSetSelectionMode);
    on<StepContinue>((event, emit) {
      if (state.currentStep < 6) {
        emit(state.copyWith(currentStep: state.currentStep + 1));
      } else {
        print('Success Step');
        emit(state.copyWith(isCompleted: true));
      }
    });
  }

  void _onStepContinue(StepContinue event, Emitter<AssessmentState> emit) {
    if (state.currentStep < 6) {
      emit(state.copyWith(currentStep: state.currentStep + 1));
    }
  }

  void _onStepBack(StepBack event, Emitter<AssessmentState> emit) {
    if (state.currentStep > 0) {
      emit(state.copyWith(currentStep: state.currentStep - 1));
    }
  }

  void _onImagePicked(ImagePicked event, Emitter<AssessmentState> emit) {
    emit(state.copyWith(selectedImage: event.image));
  }

  void _onUpdateField(UpdateField event, Emitter<AssessmentState> emit) {
    final updatedFormData = Map<String, String>.from(state.formData);
    updatedFormData[event.fieldName] = event.value;
    if (event.fieldName == 'gender') {
      emit(state.copyWith(formData: updatedFormData, genderError: false));
    } else {
      emit(state.copyWith(formData: updatedFormData));
    }
  }

  void _onValidateGender(ValidateGender event, Emitter<AssessmentState> emit) {
    final isGenderSelected = state.formData['gender'] != null;
    emit(state.copyWith(genderError: !isGenderSelected));
  }

  void _onToggleSelection(
      ToggleSelectionEvent event, Emitter<AssessmentState> emit) {
    if (event.isMultiSelect) {
      final updatedFamhisChoose = List<String>.from(state.famhisChoose);
      if (updatedFamhisChoose.contains(event.title)) {
        updatedFamhisChoose.remove(event.title);
      } else {
        updatedFamhisChoose.add(event.title);
      }
      debugPrint('Updated famhisChoose: $updatedFamhisChoose');
      emit(state.copyWith(famhisChoose: updatedFamhisChoose));
    } else {
      if (event.selectionType == 'alcohol') {
        debugPrint('Updated alcoholChoose: ${event.title}');
        emit(state.copyWith(alcoholChoose: event.title));
      } else if (event.selectionType == 'goal') {
        debugPrint('Updated goalChoose: ${event.title}');
        emit(state.copyWith(goalChoose: event.title));
      } else if (event.selectionType == 'smoke') {
        debugPrint('Updated smokeChoose: ${event.title}');
        emit(state.copyWith(smokeChoose: event.title));
      }
    }
  }

  void _onSetSelectionMode(
      SetSelectionMode event, Emitter<AssessmentState> emit) {
    emit(state.copyWith(isMultiSelect: event.isMultiSelect));
  }
}

class ToggleSelectionEvent extends AssessmentEvent {
  final String title;
  final bool isMultiSelect;
  final String selectionType;

  ToggleSelectionEvent(this.title, this.isMultiSelect, this.selectionType);

  @override
  List<Object> get props => [title, isMultiSelect, selectionType];
}

class SetSelectionMode extends AssessmentEvent {
  final bool isMultiSelect;

  SetSelectionMode(this.isMultiSelect);

  @override
  List<Object> get props => [isMultiSelect];
}
