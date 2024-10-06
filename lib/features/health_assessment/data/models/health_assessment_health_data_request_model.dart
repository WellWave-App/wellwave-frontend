// ignore_for_file: public_member_api_docs, sort_constructors_first

class HealthAssessmentHealthDataRequestModel {
  // health data
  final double? diastolicBloodPressure;
  final double? systolicBloodPressure;
  final double? hdl;
  final double? ldl;
  final double? waistLine;
  final int? hasHypertension;
  final int? hasDiabetes;
  final int? hasDyslipidemia;
  final int? hasObesity;

  HealthAssessmentHealthDataRequestModel({
    this.diastolicBloodPressure,
    this.systolicBloodPressure,
    this.hdl,
    this.ldl,
    this.waistLine,
    this.hasHypertension,
    this.hasDiabetes,
    this.hasDyslipidemia,
    this.hasObesity,
  });

  HealthAssessmentHealthDataRequestModel copyWith({
    double? diastolicBloodPressure,
    double? systolicBloodPressure,
    double? hdl,
    double? ldl,
    double? waistLine,
    int? hasHypertension,
    int? hasDiabetes,
    int? hasDyslipidemia,
    int? hasObesity,
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
      hasHypertension: json['hasHypertension'] as int? ?? 0,
      hasDiabetes: json['hasDiabetes'] as int? ?? 0,
      hasDyslipidemia: json['hasDyslipidemia'] as int? ?? 0,
      hasObesity: json['hasObesity'] as int? ?? 0,
    );
  }

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
