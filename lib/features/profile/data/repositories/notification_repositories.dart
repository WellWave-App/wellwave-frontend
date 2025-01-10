import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wellwave_frontend/features/profile/data/models/sleep_notification_response_model.dart';

import '../../../../config/constants/app_strings.dart';

class NotificationSettingRepository {
  final String baseUrl = '${AppStrings.baseUrl}/noti-setting';
  String token = AppStrings.token;

  Future<bool> createBedSetting({
    required int uid,
    required bool isActive,
    required String bedtime,
  }) async {
    final body = {
      "UID": uid,
      "IS_ACTIVE": isActive,
      "BEDTIME": bedtime,
    };

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/set-bed-time'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppStrings.token}',
        },
        body: jsonEncode(body),
      );

      // debugPrint('Response Body: ${response.body}');
      // debugPrint('Payload: ${jsonEncode(body)}');

      if (response.statusCode == 201) {
        debugPrint(
            'Bedtime setting created successfully for $uid, $isActive, $bedtime');
        return true;
      } else {
        debugPrint('Failed to update bedtime setting: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      debugPrint('Error updating bedtime setting: $error');
      return false;
    }
  }

  Future<SleepNotificationResponseModel?> fetchBedSetting() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/get-noti/BEDTIME'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppStrings.token}',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        // Extract the correct IS_ACTIVE value from the nested `bedtimeSettings` object
        final isActive = jsonData['IS_ACTIVE'];

        final bedtime = jsonData['bedtimeSettings'] != null
            ? jsonData['bedtimeSettings']['BEDTIME']
            : null;

        debugPrint('Fetched Data: isActive = $isActive, bedtime = $bedtime');

        if (isActive != null && bedtime != null) {
          return SleepNotificationResponseModel(
            isActive: isActive,
            setting: SettingDetail(
              bedtime: bedtime,
            ),
          );
        } else {
          debugPrint('Error: IS_ACTIVE or BEDTIME was null');
        }
      } else {
        debugPrint(
            'Error: Server returned non-200 status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
    return null;
  }

  Future<bool> updateBedSetting({
    required int uid,
    required bool isActive,
  }) async {
    final body = {
      "UID": uid,
      "IS_ACTIVE": isActive,
    };

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/set-bed-time'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppStrings.token}',
        },
        body: jsonEncode(body),
      );

      // debugPrint('Response Body: ${response.body}');
      // debugPrint('Payload: ${jsonEncode(body)}');

      if (response.statusCode == 201) {
        debugPrint('Bedtime setting created successfully for $uid, $isActive');
        return true;
      } else {
        debugPrint('Failed to update bedtime setting: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      debugPrint('Error updating bedtime setting: $error');
      return false;
    }
  }
}
