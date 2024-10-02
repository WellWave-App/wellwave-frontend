// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class HealthAssessmentPersonalDataRequestModel {
  final String imageUrl;
  final String username;
  final int yearOfBirth;
  final bool gender;
  final double height;
  final double weight;
  final int userGoal;
  final String email;

  HealthAssessmentPersonalDataRequestModel({
    required this.imageUrl,
    required this.username,
    required this.yearOfBirth,
    required this.gender,
    required this.height,
    required this.weight,
    required this.userGoal,
    required this.email,
  });

  HealthAssessmentPersonalDataRequestModel copyWith({
    String? imageUrl,
    String? username,
    int? yearOfBirth,
    bool? gender,
    double? height,
    double? weight,
    int? userGoal,
    String? email,
  }) {
    return HealthAssessmentPersonalDataRequestModel(
      imageUrl: imageUrl ?? this.imageUrl,
      username: username ?? this.username,
      yearOfBirth: yearOfBirth ?? this.yearOfBirth,
      gender: gender ?? this.gender,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      userGoal: userGoal ?? this.userGoal,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'IMAGE_URL': imageUrl,
      'USERNAME': username,
      'YEAR_OF_BIRTH': yearOfBirth,
      'GENDER': gender,
      'HEIGHT': height,
      'WEIGHT': weight,
      'USER_GOAL': userGoal,
      'EMAIL': email,
    };
  }

  factory HealthAssessmentPersonalDataRequestModel.fromJson(
      Map<String, dynamic> json) {
    return HealthAssessmentPersonalDataRequestModel(
      imageUrl: json['imageUrl'] as String? ?? "",
      username: json['username'] as String? ?? "",
      yearOfBirth: json['yearOfBirth'] as int? ?? 0,
      gender: json['gender'] as bool? ?? false,
      height: (json['height'] as num?)?.toDouble() ?? 0.0,
      weight: (json['weight'] as num?)?.toDouble() ?? 0.0,
      userGoal: json['userGoal'] as int? ?? 0,
      email: json['email'] as String? ?? "",
    );
  }

  // Method for editing logs request
  Map<String, dynamic> toEditLogsRequestJson(String isShowToEmployee) {
    return {
      'IMAGE_URL': imageUrl,
      'USERNAME': username,
      'YEAR_OF_BIRTH': yearOfBirth,
      'GENDER': gender,
      'HEIGHT': height,
      'WEIGHT': weight,
      'USER_GOAL': userGoal,
      'EMAIL': email,
    };
  }
}
