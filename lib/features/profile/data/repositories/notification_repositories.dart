import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
}
