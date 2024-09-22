// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class HealthAssessmentResponseModel {
  // health data
  final double bloodPressure;
  final double bloodGlucose;
  final double hdl;
  final double ldl;
  final double waistLine;
  final bool hasHypertension;
  final bool hasDiabetes;
  final bool hasDyslipidemia;
  final bool hasObesity;

  // personal data
  final String imagePath;
  final String username;
  final int yearOfBirth;
  final bool gender;
  final double height;
  final double weight;
  final int userGoal;

  HealthAssessmentResponseModel({
    required this.bloodPressure,
    required this.bloodGlucose,
    required this.hdl,
    required this.ldl,
    required this.waistLine,
    required this.hasHypertension,
    required this.hasDiabetes,
    required this.hasDyslipidemia,
    required this.hasObesity,
    required this.imagePath,
    required this.username,
    required this.yearOfBirth,
    required this.gender,
    required this.height,
    required this.weight,
    required this.userGoal,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      // ตัวใหญ่
      'bloodPressure': bloodPressure,
      'bloodGlucose': bloodGlucose,
      'hdl': hdl,
      'ldl': ldl,
      'waistLine': waistLine,
      'hasHypertension': hasHypertension,
      'hasDiabetes': hasDiabetes,
      'hasDyslipidemia': hasDyslipidemia,
      'hasObesity': hasObesity,
      'imagePath': imagePath,
      'username': username,
      'yearOfBirth': yearOfBirth,
      'gender': gender,
      'height': height,
      'weight': weight,
      'userGoal': userGoal,
    };
  }

  factory HealthAssessmentResponseModel.fromMap(Map<String, dynamic> map) {
    return HealthAssessmentResponseModel(
      bloodPressure: map['bloodPressure'] as double,
      bloodGlucose: map['bloodGlucose'] as double,
      hdl: map['hdl'] as double,
      ldl: map['ldl'] as double,
      waistLine: map['waistLine'] as double,
      hasHypertension: map['hasHypertension'] as bool,
      hasDiabetes: map['hasDiabetes'] as bool,
      hasDyslipidemia: map['hasDyslipidemia'] as bool,
      hasObesity: map['hasObesity'] as bool,
      imagePath: map['imagePath'] as String,
      username: map['username'] as String,
      yearOfBirth: map['yearOfBirth'] as int,
      gender: map['gender'] as bool,
      height: map['height'] as double,
      weight: map['weight'] as double,
      userGoal: map['userGoal'] as int,
    );
  }

  String toJson() => json.encode(<String, dynamic>{
        // ตัวใหญ่
        'bloodPressure': bloodPressure,
        'bloodGlucose': bloodGlucose,
        'hdl': hdl,
        'ldl': ldl,
        'waistLine': waistLine,
        'hasHypertension': hasHypertension,
        'hasDiabetes': hasDiabetes,
        'hasDyslipidemia': hasDyslipidemia,
        'hasObesity': hasObesity,
        'imagePath': imagePath,
        'username': username,
        'yearOfBirth': yearOfBirth,
        'gender': gender,
        'height': height,
        'weight': weight,
        'userGoal': userGoal,
      });

  factory HealthAssessmentResponseModel.fromJson(String source) =>
      HealthAssessmentResponseModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  HealthAssessmentResponseModel copyWith({
    double? bloodPressure,
    double? bloodGlucose,
    double? hdl,
    double? ldl,
    double? waistLine,
    bool? hasHypertension,
    bool? hasDiabetes,
    bool? hasDyslipidemia,
    bool? hasObesity,
    String? imagePath,
    String? username,
    int? yearOfBirth,
    bool? gender,
    double? height,
    double? weight,
    int? userGoal,
  }) {
    return HealthAssessmentResponseModel(
      bloodPressure: bloodPressure ?? this.bloodPressure,
      bloodGlucose: bloodGlucose ?? this.bloodGlucose,
      hdl: hdl ?? this.hdl,
      ldl: ldl ?? this.ldl,
      waistLine: waistLine ?? this.waistLine,
      hasHypertension: hasHypertension ?? this.hasHypertension,
      hasDiabetes: hasDiabetes ?? this.hasDiabetes,
      hasDyslipidemia: hasDyslipidemia ?? this.hasDyslipidemia,
      hasObesity: hasObesity ?? this.hasObesity,
      imagePath: imagePath ?? this.imagePath,
      username: username ?? this.username,
      yearOfBirth: yearOfBirth ?? this.yearOfBirth,
      gender: gender ?? this.gender,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      userGoal: userGoal ?? this.userGoal,
    );
  }

  @override
  String toString() {
    return 'AssessmentResponseModel(bloodPressure: $bloodPressure, bloodGlucose: $bloodGlucose, hdl: $hdl, ldl: $ldl, waistLine: $waistLine, hasHypertension: $hasHypertension, hasDiabetes: $hasDiabetes, hasDyslipidemia: $hasDyslipidemia, hasObesity: $hasObesity, imagePath: $imagePath, username: $username, yearOfBirth: $yearOfBirth, gender: $gender, height: $height, weight: $weight, userGoal: $userGoal)';
  }

  @override
  bool operator ==(covariant HealthAssessmentResponseModel other) {
    if (identical(this, other)) return true;

    return other.bloodPressure == bloodPressure &&
        other.bloodGlucose == bloodGlucose &&
        other.hdl == hdl &&
        other.ldl == ldl &&
        other.waistLine == waistLine &&
        other.hasHypertension == hasHypertension &&
        other.hasDiabetes == hasDiabetes &&
        other.hasDyslipidemia == hasDyslipidemia &&
        other.hasObesity == hasObesity &&
        other.imagePath == imagePath &&
        other.username == username &&
        other.yearOfBirth == yearOfBirth &&
        other.gender == gender &&
        other.height == height &&
        other.weight == weight &&
        other.userGoal == userGoal;
  }

  @override
  int get hashCode {
    return bloodPressure.hashCode ^
        bloodGlucose.hashCode ^
        hdl.hashCode ^
        ldl.hashCode ^
        waistLine.hashCode ^
        hasHypertension.hashCode ^
        hasDiabetes.hashCode ^
        hasDyslipidemia.hashCode ^
        hasObesity.hashCode ^
        imagePath.hashCode ^
        username.hashCode ^
        yearOfBirth.hashCode ^
        gender.hashCode ^
        height.hashCode ^
        weight.hashCode ^
        userGoal.hashCode;
  }
}
