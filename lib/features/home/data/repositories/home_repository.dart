import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/health_assessment/data/models/health_assessment_health_data_request_model.dart';
import 'package:wellwave_frontend/features/health_assessment/data/repositories/health_assessment_repository.dart';
import 'package:wellwave_frontend/features/home/data/models/login_streak_data_respone_model.dart';
import 'package:wellwave_frontend/features/home/data/models/notifications_data_respone_model.dart';
import 'package:wellwave_frontend/features/profile/data/repositories/profile_repositories.dart';

import '../../../../config/constants/app_url.dart';

const _secureStorage = FlutterSecureStorage();
String userID = '$AppStrings.uid';

extension HomeHealthDataRepository on HealthAssessmentRepository {
  Future<HealthAssessmentHealthDataRequestModel?> fetchHealthData() async {
    final token = await _secureStorage.read(key: 'access_token'); // ดึง token
    if (token == null) {
      throw Exception("No access token found");
    }
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/risk-assessment/$userID"),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        return HealthAssessmentHealthDataRequestModel.fromJson(jsonData);
      }
      return null;
    } catch (e) {
      debugPrint('Error: $e');
      return null;
    }
  }

  Future<bool> updateHealthData(Map<String, dynamic> data) async {
    final token = await _secureStorage.read(key: 'access_token'); // ดึง token
    if (token == null) {
      throw Exception("No access token found");
    }

    final url = Uri.parse('$baseUrl/risk-assessment/$userID');
    final body = jsonEncode(data);

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
        // debugPrint('Health data updated successfully: ${response.body}');
        return true;
      } else {
        debugPrint('Failed to update health data: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      debugPrint('Error updating  health data: $e');
      return false;
    }
  }
}

extension HomePersonaDataRepository on ProfileRepositories {
  Future<bool> updateWeight(double? weight) async {
    final token = await _secureStorage.read(key: 'access_token');
    if (token == null) {
      throw Exception("No access token found");
    }
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
        // debugPrint('Weight updated successfully: ${response.body}');
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
  Future<LoginStreakDataResponseModel?> fetchLoginStreakData() async {
    final token = await _secureStorage.read(key: 'access_token'); // ดึง token
    if (token == null) {
      throw Exception("No access token found");
    }
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/login-streak/update-login"),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return LoginStreakDataResponseModel.fromJson(jsonData);
      }
      return null;
    } catch (e) {
      debugPrint('Error: $e');
      return null;
    }
  }
}

class NotificationsRepository {
  Future<List<NotificationsDataResponseModel>?> fetchNotiData() async {
    final token = await _secureStorage.read(key: 'access_token'); // ดึง token
    if (token == null) {
      throw Exception("No access token found");
    }
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/notification-history/user"),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final List<dynamic> data = jsonData['data'];
        debugPrint('notification data updated successfully: ${response.body}');
        return data
            .map((item) => NotificationsDataResponseModel.fromJson(item))
            .toList();
      }
      return null;
    } catch (e) {
      debugPrint('Error: $e');
      return null;
    }
  }

  Future<bool> markAsReadNotification({
    required String notificationId,
  }) async {
    final token = await _secureStorage.read(key: 'access_token');
    if (token == null) {
      throw Exception("No access token found");
    }

    final url = Uri.parse('$baseUrl/notification-history/read/$notificationId');

    debugPrint('URL: $url');

    try {
      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        debugPrint('Notification marked as read successfully');
        return true;
      } else {
        debugPrint(
            'Failed to mark notification as read: ${response.statusCode}');
        debugPrint('Response Body: ${response.body}');
        return false;
      }
    } catch (e) {
      debugPrint('Error marking notification as read: $e');
      return false;
    }
  }
}
