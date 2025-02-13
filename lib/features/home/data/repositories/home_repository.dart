import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/health_assessment/data/repositories/health_assessment_repository.dart';
import 'package:wellwave_frontend/features/profile/data/models/profile_request_model.dart';
import 'package:wellwave_frontend/features/profile/data/repositories/profile_repositories.dart';

extension HomeHealthDataRepository on HealthAssessmentRepository {
  static const token = AppStrings.token;
  Future<Map<String, dynamic>> fetchPersonaData() async {
    final url = '$baseUrl/risk-assessment/$userID';
    debugPrint('Calling API URL: $url');

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        debugPrint('📢 API Response: $jsonData');

        final int exp = jsonData['USER']['EXP'] as int? ?? 0;
        final int gem = jsonData['USER']['GEM'] as int? ?? 0;
        final String imageUrl = jsonData['USER']['IMAGE_URL'] as String? ?? '';
        final String username =
            jsonData['USER']['USERNAME'] as String? ?? 'User';
        final int userGoalStepWeek =
            jsonData['USER']['USER_GOAL_STEP_WEEK'] as int? ?? 0;
        final int userGoalExTimeWeek =
            jsonData['USER']['USER_GOAL_EX_TIME_WEEK'] as int? ?? 0;

        return {
          'exp': exp,
          'gem': gem,
          'imageUrl': imageUrl,
          'username': username,
          'userGoalStepWeek': userGoalStepWeek,
          'userGoalExTimeWeek': userGoalExTimeWeek,
        };
      } else {
        throw Exception(
            'Failed to fetch user data from API ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching data: $e');
      return {
        'exp': 0,
        'gem': 0,
        'imageUrl': '',
        'username': 'User',
        'userGoalStepWeek': 0,
        'userGoalExTimeWeek': 0,
      };
    }
  }

  Future<Map<String, dynamic>> fetchHealthData() async {
    final url = '$baseUrl/risk-assessment/$userID';
    debugPrint('Calling API URL: $url');

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        debugPrint('📢 API Response: $jsonData');

        final double diastolicBloodPressure =
            (jsonData['DIASTOLIC_BLOOD_PRESSURE'] ?? 0).toDouble();
        final double systolicBloodPressure =
            (jsonData['SYSTOLIC_BLOOD_PRESSURE'] ?? 0).toDouble();
        final double hdl = (jsonData['HDL'] ?? 0).toDouble();
        final double ldl = (jsonData['LDL'] ?? 0).toDouble();
        final double waistLine = (jsonData['WAIST_LINE'] ?? 0).toDouble();
        final double weight = (jsonData['USER']['WEIGHT'] ?? 0).toDouble();

        return {
          'diastolicBloodPressure': diastolicBloodPressure,
          'systolicBloodPressure': systolicBloodPressure,
          'hdl': hdl,
          'ldl': ldl,
          'waistLine': waistLine,
          'weight': weight,
        };
      } else {
        throw Exception(
            'Failed to fetch health data from API ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching data: $e');
      return {
        'diastolicBloodPressure': 0.0,
        'systolicBloodPressure': 0.0,
        'hdl': 0.0,
        'ldl': 0.0,
        'waistLine': 0.0,
        'weight': 0.0,
      };
    }
  }
}

extension HomePersonaDataRepository on ProfileRepositories {
  Future<bool> updateWeight(double? weight) async {
    String userID = AppStrings.userID;
    final url = Uri.parse('$baseUrl/users/$userID');
    final body = jsonEncode({'WEIGHT': weight});

    debugPrint('Sending PATCH request to $url');
    debugPrint('Request body: $body');

    try {
      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        debugPrint('Weight updated successfully: ${response.body}');
        return true;
      } else {
        debugPrint('Failed to update weight: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      debugPrint('Error updating weight: $e');
      return false;
    }
  }
}

class LoginStreakRepository {
  LoginStreakRepository();

  String baseUrl = AppStrings.baseUrl;
  static const token = AppStrings.token;

  Future<Map<String, dynamic>> fetchLoginStreakData() async {
    final url = '$baseUrl/login-streak/update-login';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        debugPrint('fetchLoginStreakData API Response: $jsonData');

        final int currentStreak = jsonData['CURRENT_STREAK'] as int? ?? 0;
        debugPrint('$currentStreak');
        return {
          'currentStreak': currentStreak,
        };
      } else {
        throw Exception(
            'Failed to fetch user data from fetchLoginStreakData ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching data: $e');
      return {
        'currentStreak': 0,
      };
    }
  }
}
