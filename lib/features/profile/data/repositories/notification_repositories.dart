import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../config/constants/app_strings.dart';

class NotificationSettingRepository {
  final String baseUrl = AppStrings.baseUrl;
  String token = AppStrings.token;

  // NotificationSettingRepository(this.baseUrl);

  Future<bool> createBedtime({
    required int uid,
    required bool isActive,
    required String bedtime,
  }) async {
    final url = Uri.parse('$baseUrl/noti-setting/set-bed-time');

    final body = jsonEncode({
      'UID': uid,
      'IS_ACTIVE': isActive,
      'BEDTIME': bedtime,
    });

    debugPrint('Preparing to send API request to $url'); // Debugging log
    debugPrint('Request body: $body'); // Debugging log

    try {
      debugPrint('Sending POST request to $url with body: $body');
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: body,
      );

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to create bedtime setting: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error: $e');
      rethrow;
    }
  }
}
