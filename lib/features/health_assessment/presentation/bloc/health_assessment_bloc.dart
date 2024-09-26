import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/config/constants/enums/risk_condition.dart';
import 'package:wellwave_frontend/features/health_assessment/data/repositories/health_assessment_repository.dart';
import 'health_assessment_event.dart';
import 'health_assessment_state.dart';

class ValidateGender extends AssessmentEvent {}

class AssessmentBloc extends Bloc<AssessmentEvent, AssessmentState> {
  final ScoreCalculator scoreCalculator = ScoreCalculator();

  AssessmentBloc()
      : super(const AssessmentState(
          currentStep: 0,
          formData: {},
          selectedItems: [],
          isMultiSelect: false,
        )) {
    on<StepBack>((event, emit) {
      if (state.currentStep == 0) {
        emit(state.copyWith(showStartStep: true));
      } else
        emit(state.copyWith(currentStep: state.currentStep - 1));
    });
    void _onImagePicked(ImagePicked event, Emitter<AssessmentState> emit) {
      final updatedFormData = Map<String, String>.from(state.formData);
      updatedFormData['imageUrl'] = event.imageFile.path;

      emit(state.copyWith(
        formData: updatedFormData,
        selectedImage: event.imageFile,
      ));
    }

    on<UpdateField>(_onUpdateField);
    on<ValidateGender>(_onValidateGender);
    on<ToggleSelectionEvent>(_onToggleSelection);
    on<SetSelectionMode>(_onSetSelectionMode);
    on<StepContinue>((event, emit) {
      if (state.currentStep < 6) {
        emit(state.copyWith(currentStep: state.currentStep + 1));
      } else {
        debugPrint('Success Step');
        emit(state.copyWith(isCompleted: true));
      }
    });

    on<ShowHealthConnectEvent>((event, emit) {
      emit(state.copyWith(showHealthConnect: true));
    });
    on<ShowRecommendEvent>((event, emit) {
      emit(state.copyWith(showRecommend: true));
    });
    on<ShowFinishEvent>((event, emit) {
      emit(state.copyWith(showFinish: true));
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

  void _onUpdateField(UpdateField event, Emitter<AssessmentState> emit) {
    final updatedFormData = Map<String, String>.from(state.formData);
    updatedFormData[event.fieldName] = event.value;

    ScoreCalculator scoreCalculator = ScoreCalculator();
    RiskScores riskScores = scoreCalculator.calculateScore(
        updatedFormData, state.famhisChoose, state.goalChoose);

    emit(state.copyWith(
      formData: updatedFormData,
      riskDiabetesScore: riskScores.riskDiabetesScore,
      riskHypertensionScore: riskScores.riskHypertensionScore,
      riskDyslipidemiaScore: riskScores.riskDyslipidemiaScore,
      riskObesityScore: riskScores.riskObesityScore,
    ));
  }

  void _onUpdateRiskScore(
      UpdateRiskScoreEvent event, Emitter<AssessmentState> emit) {
    int updatedDiabetesScore = state.riskDiabetesScore;
    int updatedHypertensionScore = state.riskHypertensionScore;
    int updatedDyslipidemiaScore = state.riskDyslipidemiaScore;
    int updatedObesityScore = state.riskObesityScore;

    switch (event.scoreType) {
      case 'diabetes':
        updatedDiabetesScore += event.scoreToAdd;
        break;
      case 'hypertension':
        updatedHypertensionScore += event.scoreToAdd;
        break;
      case 'dyslipidemia':
        updatedDyslipidemiaScore += event.scoreToAdd;
        break;
      case 'obesity':
        updatedObesityScore += event.scoreToAdd;
        break;
    }

    emit(state.copyWith(
      riskDiabetesScore: updatedDiabetesScore,
      riskHypertensionScore: updatedHypertensionScore,
      riskDyslipidemiaScore: updatedDyslipidemiaScore,
      riskObesityScore: updatedObesityScore,
    ));
  }

  void _onValidateGender(ValidateGender event, Emitter<AssessmentState> emit) {
    final isGenderSelected = state.formData['gender'] != null;

    emit(state.copyWith(genderError: !isGenderSelected));
  }

  void _onToggleSelection(
      ToggleSelectionEvent event, Emitter<AssessmentState> emit) {
    if (event.selectionType == 'famhis') {
      var updatedFamhisChoose = List<String>.from(state.famhisChoose);
      if (event.title == AppStrings.unknownDiseaseText) {
        updatedFamhisChoose = [AppStrings.unknownDiseaseText];
      } else {
        updatedFamhisChoose.remove(AppStrings.unknownDiseaseText);

        if (event.isMultiSelect) {
          if (updatedFamhisChoose.contains(event.title)) {
            updatedFamhisChoose.remove(event.title);
          } else {
            updatedFamhisChoose.add(event.title);
          }
        }
      }
      debugPrint('Updated famhisChoose: $updatedFamhisChoose');
      emit(state.copyWith(famhisChoose: updatedFamhisChoose));
    } else {
      if (event.selectionType == 'alcohol') {
        // debugPrint('Updated alcoholChoose: ${event.title}');
        emit(state.copyWith(alcoholChoose: event.title));
      } else if (event.selectionType == 'goal') {
        // debugPrint('Updated goalChoose: ${event.title}');
        int userGoal = mapGoalToUserGoal(event.title);
        debugPrint('userGoal: $userGoal');
        emit(state.copyWith(goalChoose: event.title));
      } else if (event.selectionType == 'smoke') {
        // debugPrint('Updated smokeChoose: ${event.title}');
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
