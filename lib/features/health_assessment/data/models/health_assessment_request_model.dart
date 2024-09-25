// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class HealthAssessmentRequestModel {
  // health data
  final double diastolicBloodPressure;
  final double systolicBloodPressure;
  final double hdl;
  final double ldl;
  final double waistLine;
  final bool hasHypertension;
  final bool hasDiabetes;
  final bool hasDyslipidemia;
  final bool hasObesity;

  // personal data
  final String imageUrl;
  final String username;
  final int yearOfBirth;
  final int gender;
  final double height;
  final double weight;
  final int userGoal;

  HealthAssessmentRequestModel({
    required this.diastolicBloodPressure,
    required this.systolicBloodPressure,
    required this.hdl,
    required this.ldl,
    required this.waistLine,
    required this.hasHypertension,
    required this.hasDiabetes,
    required this.hasDyslipidemia,
    required this.hasObesity,
    required this.imageUrl,
    required this.username,
    required this.yearOfBirth,
    required this.gender,
    required this.height,
    required this.weight,
    required this.userGoal,
  });

  HealthAssessmentRequestModel copyWith({
    double? diastolicBloodPressure,
    double? systolicBloodPressure,
    double? hdl,
    double? ldl,
    double? waistLine,
    bool? hasHypertension,
    bool? hasDiabetes,
    bool? hasDyslipidemia,
    bool? hasObesity,
    String? imageUrl,
    String? username,
    int? yearOfBirth,
    int? gender,
    double? height,
    double? weight,
    int? userGoal,
  }) {
    return HealthAssessmentRequestModel(
      diastolicBloodPressure:
          diastolicBloodPressure ?? this.diastolicBloodPressure,
      systolicBloodPressure:
          systolicBloodPressure ?? this.systolicBloodPressure,
      hdl: hdl ?? this.hdl,
      ldl: ldl ?? this.ldl,
      waistLine: waistLine ?? this.waistLine,
      hasHypertension: hasHypertension ?? this.hasHypertension,
      hasDiabetes: hasDiabetes ?? this.hasDiabetes,
      hasDyslipidemia: hasDyslipidemia ?? this.hasDyslipidemia,
      hasObesity: hasObesity ?? this.hasObesity,
      imageUrl: imageUrl ?? this.imageUrl,
      username: username ?? this.username,
      yearOfBirth: yearOfBirth ?? this.yearOfBirth,
      gender: gender ?? this.gender,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      userGoal: userGoal ?? this.userGoal,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'DIASTOLIC_BLOOD_PRESSURE': diastolicBloodPressure,
      'SYSTOLIC_BLOOD_PRESSURE': systolicBloodPressure,
      'HDL': hdl,
      'LDL': ldl,
      'WAIST_LINE': waistLine,
      'HAS_HYPERTENSION': hasHypertension,
      'HAS_DIABETES': hasDiabetes,
      'HAS_DYSLIPIDEMIA': hasDyslipidemia,
      'HAS_OBESITY': hasObesity,
      'IMAGE_PATH': imageUrl,
      'USERNAME': username,
      'YEAR_OF_BIRTH': yearOfBirth,
      'GENDER': gender,
      'HEIGHT': height,
      'WEIGHT': weight,
      'USER_GOAL': userGoal,
    };
  }

  factory HealthAssessmentRequestModel.fromJson(Map<String, dynamic> json) {
    return HealthAssessmentRequestModel(
      diastolicBloodPressure:
          (json['diastolicBloodPressure'] as num?)?.toDouble() ?? 0.0,
      systolicBloodPressure:
          (json['systolicBloodPressure'] as num?)?.toDouble() ?? 0.0,
      hdl: (json['hdl'] as num?)?.toDouble() ?? 0.0,
      ldl: (json['ldl'] as num?)?.toDouble() ?? 0.0,
      waistLine: (json['waistLine'] as num?)?.toDouble() ?? 0.0,
      hasHypertension: json['hasHypertension'] as bool? ?? false,
      hasDiabetes: json['hasDiabetes'] as bool? ?? false,
      hasDyslipidemia: json['hasDyslipidemia'] as bool? ?? false,
      hasObesity: json['hasObesity'] as bool? ?? false,
      imageUrl: json['imageUrl'] as String? ?? "",
      username: json['username'] as String? ?? "",
      yearOfBirth: json['yearOfBirth'] as int? ?? 0,
      gender: json['gender'] as int? ?? 0,
      height: (json['height'] as num?)?.toDouble() ?? 0.0,
      weight: (json['weight'] as num?)?.toDouble() ?? 0.0,
      userGoal: json['userGoal'] as int? ?? 0,
    );
  }

  // Method for editing logs request
  Map<String, dynamic> toEditLogsRequestJson(String isShowToEmployee) {
    return {
      'DIASTOLIC_BLOOD_PRESSURE': diastolicBloodPressure,
      'SYSTOLIC_BLOOD_PRESSURE': systolicBloodPressure,
      'HDL': hdl,
      'LDL': ldl,
      'WAIST_LINE': waistLine,
      'HAS_HYPERTENSION': hasHypertension,
      'HAS_DIABETES': hasDiabetes,
      'HAS_DYSLIPIDEMIA': hasDyslipidemia,
      'HAS_OBESITY': hasObesity,
      'IMAGE_PATH': imageUrl,
      'USERNAME': username,
      'YEAR_OF_BIRTH': yearOfBirth,
      'GENDER': gender,
      'HEIGHT': height,
      'WEIGHT': weight,
      'USER_GOAL': userGoal,
    };
  }
}
