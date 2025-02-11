import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/health_assessment/data/repositories/health_assessment_repository.dart';
import 'package:wellwave_frontend/features/home/data/models/login_streak_data_respone_model.dart';

extension HomeRepository on HealthAssessmentRepository {
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
