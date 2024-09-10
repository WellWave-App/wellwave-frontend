import 'package:equatable/equatable.dart';
import 'dart:io';

class AssessmentState extends Equatable {
  final int currentStep;
  final Map<String, String> formData;
  final bool genderError;
  final File? selectedImage;
  final List<String> selectedItems;
  final bool isMultiSelect;
  final String? alcoholChoose; // สำหรับ single choice
  final List<String> famhisChoose; // สำหรับ multiple choice

  // Constructor
  AssessmentState({
    required this.currentStep,
    required this.formData,
    this.genderError = false,
    this.selectedImage,
    this.selectedItems = const [],
    this.isMultiSelect = false,
    this.alcoholChoose,
    this.famhisChoose = const [],
  });

  // Copy method for state management
  AssessmentState copyWith({
    int? currentStep,
    Map<String, String>? formData,
    bool? genderError,
    File? selectedImage,
    List<String>? selectedItems,
    bool? isMultiSelect,
    String? alcoholChoose,
    List<String>? famhisChoose,
  }) {
    return AssessmentState(
      currentStep: currentStep ?? this.currentStep,
      formData: formData ?? this.formData,
      genderError: genderError ?? this.genderError,
      selectedImage: selectedImage ?? this.selectedImage,
      selectedItems: selectedItems ?? this.selectedItems,
      isMultiSelect: isMultiSelect ?? this.isMultiSelect,
      alcoholChoose: alcoholChoose ?? this.alcoholChoose,
      famhisChoose: famhisChoose ?? this.famhisChoose,
    );
  }

  @override
  List<Object?> get props => [
        currentStep,
        formData,
        genderError,
        selectedImage,
        selectedItems,
        isMultiSelect,
        alcoholChoose,
        famhisChoose
      ];
}
