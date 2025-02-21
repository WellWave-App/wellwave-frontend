import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/config/constants/app_url.dart';
import 'package:wellwave_frontend/features/health_assessment/data/models/health_assessment_health_data_request_model.dart';
import 'package:wellwave_frontend/features/health_assessment/data/repositories/health_assessment_repository.dart';
import 'package:wellwave_frontend/features/home/data/models/health_data_step_and_ex_respone_model.dart';
import 'package:wellwave_frontend/features/home/data/models/login_streak_data_respone_model.dart';
import 'package:wellwave_frontend/features/home/data/models/notifications_data_respone_model.dart';
import 'package:wellwave_frontend/features/profile/data/repositories/profile_repositories.dart';
import 'package:wellwave_frontend/config/constants/app_url.dart';

extension HomeHealthDataRepository on HealthAssessmentRepository {
  static final _secureStorage = const FlutterSecureStorage();
  static const _tokenKey = 'access_token';
  Future<HealthAssessmentHealthDataRequestModel?> fetchHealthData() async {
    final token = await _secureStorage.read(key: _tokenKey);
    final uid = await _secureStorage.read(key: 'user_uid');
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/risk-assessment/$uid"),
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
    final token = await _secureStorage.read(key: _tokenKey);
    final uid = await _secureStorage.read(key: 'user_uid');
    final url = Uri.parse('$baseUrl/risk-assessment/$uid');
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
  static final _secureStorage = const FlutterSecureStorage();
  static const _tokenKey = 'access_token';
  Future<bool> updateWeight(double? weight) async {
    final token = await _secureStorage.read(key: _tokenKey);
    final uid = await _secureStorage.read(key: 'user_uid');
    final url = Uri.parse('$baseUrl/users/$uid');
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
  final _secureStorage = const FlutterSecureStorage();
  final _tokenKey = 'access_token';
  Future<LoginStreakDataResponseModel?> fetchLoginStreakData() async {
    final token = await _secureStorage.read(key: _tokenKey);

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
  final _secureStorage = const FlutterSecureStorage();
  final _tokenKey = 'access_token';

  Future<List<NotificationsDataResponseModel>?> fetchNotiData() async {
    final token = await _secureStorage.read(key: _tokenKey);
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

  Future<bool> markAllAsReadNotification() async {
    final token = await _secureStorage.read(key: _tokenKey);

    final url = Uri.parse('$baseUrl/notification-history/mark-all-read');

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
        // debugPrint('Notification marked as read successfully');
        return true;
      } else {
        debugPrint(
            'Failed to mark notification as read: ${response.statusCode}');

        return false;
      }
    } catch (e) {
      debugPrint('Error marking notification as read: $e');
      return false;
    }
  }

  Future<bool> markAsReadNotification({
    required String notificationId,
  }) async {
    final token = await _secureStorage.read(key: _tokenKey);

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

class HealthDataRepository {
  final _secureStorage = const FlutterSecureStorage();
  final _tokenKey = 'access_token';

  Future<HealthDataStepAndExResponeModel?> fetchStepAndExTimeData() async {
    final token = await _secureStorage.read(key: _tokenKey);
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/users/logs-progress"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        // debugPrint('response ${response.body}');
        return HealthDataStepAndExResponeModel.fromJson(jsonData);
      } else {
        debugPrint('Error: Server responded with ${response.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('Error: $e');
      return null;
    }
  }
}
