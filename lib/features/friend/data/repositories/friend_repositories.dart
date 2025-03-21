import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wellwave_frontend/features/profile/data/models/profile_request_model.dart';
import 'package:wellwave_frontend/config/constants/app_url.dart';
import 'package:wellwave_frontend/features/profile/data/repositories/profile_repositories.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _secureStorage = FlutterSecureStorage();

extension FriendRepositories on ProfileRepositories {
  Future<ProfileRequestModel?> getUserById(int uid) async {
    final token = await _secureStorage.read(key: 'access_token');
    if (token == null) {
      throw Exception("No access token found");
    }

    try {
      final url = '$baseUrl/users/$uid';
      debugPrint('Calling API URL: $url');

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      switch (response.statusCode) {
        case 200:
          final jsonData = jsonDecode(response.body);
          return ProfileRequestModel.fromJson({'userInfo': jsonData});

        default:
          throw Exception('Failed to get user by ID: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error caught in getUserById: $e');
    }
  }
}
