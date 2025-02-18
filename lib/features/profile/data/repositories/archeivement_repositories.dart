import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wellwave_frontend/features/profile/data/models/all_archeivement_request_model.dart';
import 'package:wellwave_frontend/features/profile/data/models/archeivement_request_model.dart';
import 'package:http/http.dart' as http;

import '../../../../config/constants/app_strings.dart';

class ArcheivementRepositories {
  String baseUrl = AppStrings.baseUrl;
  String token = AppStrings.token;

  Future<List<ArcheivementRequestModel>?> getUserArcheivement() async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/achievement/user-achieveds"),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final List<dynamic> achievementsJson = jsonData['data'];
        return achievementsJson
            .map((json) => ArcheivementRequestModel.fromJson(json))
            .toList();
      }
      return null;
    } catch (e) {
      debugPrint('Error: $e');
      return null;
    }
  }

  Future<List<AllArcheivementRequestModel>?> getAllArcheivement() async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/achievement"),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final List<dynamic> achievementsJson = jsonData['data'];
        return achievementsJson
            .map((json) => AllArcheivementRequestModel.fromJson(json))
            .toList();
      }
      return null;
    } catch (e) {
      debugPrint('Error: $e');
      return null;
    }
  }

  Future<bool> readArcheivement({
    required int uid,
    required String achId,
    required int level,
  }) async {
    try {
      final uri =
          Uri.parse("$baseUrl/achievement/mark-as-read/$uid/$achId/$level");

      final request = http.MultipartRequest('PATCH', uri)
        ..headers['Authorization'] = 'Bearer $token';

      final response = await request.send();

      debugPrint('mark as read: ${response.statusCode}');

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception(
            'Failed to mark as read. Status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error: $e');
      throw Exception('Error mark as read: $e');
    }
  }
}
