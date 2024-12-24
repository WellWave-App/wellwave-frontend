import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wellwave_frontend/features/profile/data/models/profile_request_model.dart';

class ProfileRepositories {
  String baseUrl = 'http://10.0.2.2:3000';
  String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJFTUFJTCI6InRlc3R4eEBleGFtcGxlLmNvbSIsIlVJRCI6NSwiaWF0IjoxNzM1MDE2MjE1LCJleHAiOjE3MzUxMDI2MTV9.jgvKh_s4EWvdwpMNXnhzYesx0ISM0-mDb3tOVg20V24";

  Future<bool> editUserRequest({
    required int uid,
    required String imageUrl,
    required String username,
    required int yearOfBirth,
    required bool gender,
    required num height,
    required num weight,
  }) async {
    try {
      final uri = Uri.parse("$baseUrl/users/$uid");

      final Map<String, String> userDetails = {
        'USERNAME': username,
        'YEAR_OF_BIRTH': yearOfBirth.toString(),
        'GENDER': gender.toString(),
        'HEIGHT': height.toString(),
        'WEIGHT': weight.toString(),
        'IMAGE_URL': imageUrl,
      };

      final request = http.MultipartRequest('PATCH', uri)
        ..headers['Authorization'] = 'Bearer $token'
        ..fields.addAll(userDetails);

      // request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      debugPrint('Edit Profile: ${response.statusCode}');
      debugPrint('Response Body: $responseBody');

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception(
            'Failed to edit user. Status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error: $e');
      throw Exception('Error editing user: $e');
    }
  }

  Future<ProfileRequestModel?> getUSer() async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/users/profile"),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return ProfileRequestModel.fromJson(jsonData);
      }
      return null;
    } catch (e) {
      debugPrint('Error: $e');
      return null;
    }
  }

  Future<String?> uploadProfileImage(
    File imageFile,
    int uid,
  ) async {
    try {
      final uri = Uri.parse("$baseUrl/users/$uid");
      final request = http.MultipartRequest('PATCH', uri)
        ..files.add(await http.MultipartFile.fromPath('image', imageFile.path));

      // Add headers if necessary
      request.headers['Authorization'] = 'Bearer $token';

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final responseJson = jsonDecode(responseBody);
        final imageUrl = responseJson['IMAGE_URL'] as String?;
        return imageUrl;
      } else {
        throw Exception('Failed to upload image');
      }
    } catch (e) {
      throw Exception('Error uploading image: $e');
    }
  }
}
