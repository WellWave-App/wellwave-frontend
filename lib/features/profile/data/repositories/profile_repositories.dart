import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wellwave_frontend/features/profile/data/models/profile_request_model.dart';

class ProfileRepositories {
  String baseUrl = 'http://10.0.2.2:3000';

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

  Future<ProfileRequestModel?> getUserById(int uid) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/users/$uid"));
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

  Future<String> uploadImage(File imageFile, int uid) async {
    try {
      final uri = Uri.parse("$baseUrl/users/$uid");
      final request = http.MultipartRequest('PATCH', uri)
        ..fields['uid'] = uid.toString()
        ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final responseData = jsonDecode(responseBody);
        final uploadedImageUrl = responseData['IMAGE_URL'];
        return uploadedImageUrl;
      } else {
        throw Exception(
            'Failed to upload image. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error uploading image: $e');
    }
  }
}
