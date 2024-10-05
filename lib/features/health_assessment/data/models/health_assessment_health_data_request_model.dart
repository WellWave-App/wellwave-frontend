// ignore_for_file: public_member_api_docs, sort_constructors_first

class HealthAssessmentHealthDataRequestModel {
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

  HealthAssessmentHealthDataRequestModel({
    required this.diastolicBloodPressure,
    required this.systolicBloodPressure,
    required this.hdl,
    required this.ldl,
    required this.waistLine,
    required this.hasHypertension,
    required this.hasDiabetes,
    required this.hasDyslipidemia,
    required this.hasObesity,
  });

  HealthAssessmentHealthDataRequestModel copyWith({
    double? diastolicBloodPressure,
    double? systolicBloodPressure,
    double? hdl,
    double? ldl,
    double? waistLine,
    bool? hasHypertension,
    bool? hasDiabetes,
    bool? hasDyslipidemia,
    bool? hasObesity,
  }) {
    return HealthAssessmentHealthDataRequestModel(
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
    };
  }

  factory HealthAssessmentHealthDataRequestModel.fromJson(
      Map<String, dynamic> json) {
    return HealthAssessmentHealthDataRequestModel(
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
    };
  }
}
