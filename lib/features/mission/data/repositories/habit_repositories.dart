import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:wellwave_frontend/features/mission/data/models/habit_request_model.dart';
import 'package:wellwave_frontend/features/mission/data/models/rec_habit_respone_model.dart';
import '../../../../config/constants/app_url.dart';

class HabitRepositories {
  final _secureStorage = const FlutterSecureStorage();

  Future<HabitRequestModel?> getHabitAll({String? category}) async {
    final token = await _secureStorage.read(key: 'access_token');
    if (token == null) {
      throw Exception("No access token found");
    }

    try {
      final queryParams = {
        'filter': 'all',
        if (category != null) 'category': category,
      };

      final uri =
          Uri.parse(baseUrl + '/habit').replace(queryParameters: queryParams);
      debugPrint('Calling API URL: $uri');

      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return HabitRequestModel.fromJson(jsonData);
      }
      return null;
    } catch (e) {
      debugPrint('Error: $e');
      return null;
    }
  }

  Future<RecHabitResponseModel?> getRecHabit() async {
    final token = await _secureStorage.read(key: 'access_token');
    if (token == null) {
      throw Exception("No access token found");
    }
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/get-rec/test-habits"),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return RecHabitResponseModel.fromJson(jsonData);
      }
      return null;
    } catch (e) {
      debugPrint('Error: $e');
      return null;
    }
  }
}
