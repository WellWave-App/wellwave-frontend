import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:io';

import 'health_assessment_event.dart';
import 'health_assessment_state.dart';

class ValidateGender extends AssessmentEvent {}

class AssessmentBloc extends Bloc<AssessmentEvent, AssessmentState> {
  AssessmentBloc()
      : super(AssessmentState(
            currentStep: 0,
            formData: {},
            selectedItems: [],
            isMultiSelect: false)) {
    // Registering the event handlers
    on<StepContinue>(_onStepContinue);
    on<StepBack>(_onStepBack);
    on<ImagePicked>(_onImagePicked);
    on<UpdateField>(_onUpdateField);
    on<ValidateGender>(_onValidateGender);
    on<ToggleSelectionEvent>(_onToggleSelection);
    on<SetSelectionMode>(_onSetSelectionMode);
  }

  // Event handler for StepContinue
  void _onStepContinue(StepContinue event, Emitter<AssessmentState> emit) {
    if (state.currentStep < 6) {
      emit(state.copyWith(currentStep: state.currentStep + 1));
    }
  }

  // Event handler for StepBack
  void _onStepBack(StepBack event, Emitter<AssessmentState> emit) {
    if (state.currentStep > 0) {
      emit(state.copyWith(currentStep: state.currentStep - 1));
    }
  }

  // Event handler for ImagePicked
  void _onImagePicked(ImagePicked event, Emitter<AssessmentState> emit) {
    emit(state.copyWith(selectedImage: event.image));
  }

  // Event handler for UpdateField
  void _onUpdateField(UpdateField event, Emitter<AssessmentState> emit) {
    final updatedFormData = Map<String, String>.from(state.formData);
    updatedFormData[event.fieldName] = event.value;
    if (event.fieldName == 'gender') {
      emit(state.copyWith(formData: updatedFormData, genderError: false));
    } else {
      emit(state.copyWith(formData: updatedFormData));
    }
  }

  // Event handler for ValidateGender
  void _onValidateGender(ValidateGender event, Emitter<AssessmentState> emit) {
    final isGenderSelected = state.formData['gender'] != null;
    emit(state.copyWith(
        genderError:
            !isGenderSelected)); // If gender is not selected, set error
  }

  // Event handler for ToggleSelectionEvent
  void _onToggleSelection(
      ToggleSelectionEvent event, Emitter<AssessmentState> emit) {
    if (event.isMultiSelect) {
      // สำหรับ multiple choice (famhis_choose)
      final updatedFamhisChoose = List<String>.from(state.famhisChoose);
      if (updatedFamhisChoose.contains(event.title)) {
        // ถ้ามีการเลือกอยู่แล้ว ให้เอาออก
        updatedFamhisChoose.remove(event.title);
      } else {
        // ถ้ายังไม่มี ให้เพิ่มเข้าไป
        updatedFamhisChoose.add(event.title);
      }
      emit(state.copyWith(famhisChoose: updatedFamhisChoose));
    } else {
      // สำหรับ single choice (alcohol_choose)
      emit(state.copyWith(alcoholChoose: event.title)); // เลือกค่าเดียว
    }
  }

  // Event handler for changing selection mode (single or multiple)
  void _onSetSelectionMode(
      SetSelectionMode event, Emitter<AssessmentState> emit) {
    emit(state.copyWith(isMultiSelect: event.isMultiSelect));
  }
}

// The ToggleSelectionEvent class
class ToggleSelectionEvent extends AssessmentEvent {
  final String title;
  final bool isMultiSelect;
  ToggleSelectionEvent(this.title, this.isMultiSelect);

  @override
  List<Object> get props => [title, isMultiSelect];
}

class SetSelectionMode extends AssessmentEvent {
  final bool isMultiSelect;

  SetSelectionMode(this.isMultiSelect);

  @override
  List<Object> get props => [isMultiSelect];
}
