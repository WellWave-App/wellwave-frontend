import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wellwave_frontend/features/friend/presentation/bloc/friend_state.dart';
import 'package:wellwave_frontend/features/profile/data/models/profile_request_model.dart';
import 'package:wellwave_frontend/features/profile/data/repositories/profile_repositories.dart';

extension FriendRepositories on ProfileRepositories {
  Future<ProfileRequestModel?> getUserById(int uid) async {
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

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return ProfileRequestModel.fromJson({'userInfo': jsonData});
      } else if (response.statusCode == 404) {
        debugPrint('User not found, returning null');
        return null;
      } else {
        throw Exception('Failed to get user by ID');
      }
    } catch (e) {
      throw Exception('Error caught in getUserById: $e');
    }
  }
}
