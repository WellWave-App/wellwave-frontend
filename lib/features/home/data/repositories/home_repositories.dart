import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wellwave_frontend/features/health_assessment/data/repositories/health_assessment_repository.dart';

extension HomeRepositories on HealthAssessmentRepository {
  static const token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJFTUFJTCI6Im1tMnRlc3RpbmdAZXhhbXBsZS5jb20iLCJVSUQiOjcsIlJPTEUiOiJ1c2VyIiwiaWF0IjoxNzM4ODY4MTMwLCJleHAiOjE3Mzg5NTQ1MzB9.qUGetJqaZdLvVmmsAkEZpDSOTDsfCWlImzUGb36rNFc';

  Future<Map<String, dynamic>> fetchDataFromHealthAssessment() async {
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
            jsonData['USER']['USER_GOAL_STEP_WEEK'] as int? ?? 10000;
        final int userGoalExTimeWeek =
            jsonData['USER']['USER_GOAL_EX_TIME_WEEK'] as int? ?? 150;

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
        'userGoalStepWeek': 10000,
        'userGoalExTimeWeek': 150,
      };
    }
  }
}
