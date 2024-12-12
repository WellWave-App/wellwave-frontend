import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wellwave_frontend/features/logs/data/models/logs_request_model_waistline.dart';
import 'package:wellwave_frontend/features/logs/data/models/logs_request_model_weekly.dart';
import 'package:wellwave_frontend/features/logs/data/models/logs_request_model_weight.dart';
import 'package:wellwave_frontend/features/profile/data/models/profile_request_model.dart';
import '../../../logs/data/models/logs_request_model.dart';

class ProfileRepositories {
  Future<bool> editUserRequest({
    required int uid,
    required String imageUrl,
    required String username,
    required int yearOfBirth,
    required bool gender,
    required double height,
    required double weight,
  }) async {
    String baseUrl = 'http://10.0.2.2:3000';
    try {
      final response = await http.patch(
        Uri.parse("$baseUrl/users/$uid"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'IMAGE_URL': imageUrl,
          'USERNAME': username,
          'YEAR_OF_BIRTH': yearOfBirth,
          'GENDER': gender,
          'HEIGHT': height,
          'WEIGHT': weight,
        }),
      );

      debugPrint(
          'Edit Profile: ${response.statusCode}, Body: ${response.body}');

      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Error: $e');
      return false;
    }
  }

  Future<List<ProfileRequestModel?>> getUserById(num uid) async {
    try {
      String baseUrl = 'http://10.0.2.2:3000';
      final response = await http.get(
        Uri.parse("$baseUrl/users/$uid"),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        List<dynamic> userJson = jsonData['USERS'];

        debugPrint("$baseUrl/users/$uid");
        return userJson
            .map((user) =>
                ProfileRequestModel.fromJson(user as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (e) {
      debugPrint('Error: $e');
      return [];
    }
  }
}
