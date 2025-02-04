import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:http_parser/http_parser.dart';

import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/profile/data/models/profile_request_model.dart';

class ProfileRepositories {
  String baseUrl = AppStrings.baseUrl;
  String token = AppStrings.token;

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

      final response = await request.send();
      // final responseBody = await response.stream.bytesToString();

      debugPrint('Edit Profile: ${response.statusCode}');
      // debugPrint('Response Body: $responseBody');

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

  Future<bool> setGoalPerWeek(
      {required int uid,
      required int stepPerWeek,
      required int exercisePerWeek}) async {
    try {
      final uri = Uri.parse("$baseUrl/users/$uid");

      final Map<String, String> userDetails = {
        'USER_GOAL_STEP_WEEK': stepPerWeek.toString(),
        'USER_GOAL_EX_TIME_WEEK': exercisePerWeek.toString()
      };

      final request = http.MultipartRequest('PATCH', uri)
        ..headers['Authorization'] = 'Bearer $token'
        ..fields.addAll(userDetails);

      final response = await request.send();
      // final responseBody = await response.stream.bytesToString();

      // debugPrint('Response Body: $responseBody');

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception(
            'Failed to edit user goal per week. Status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error: $e');
      throw Exception('Error editing user goal per week: $e');
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
      // debugPrint('Response body: ${response.body}');

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

  Future<String?> uploadProfileImage(File imageFile, int uid) async {
    try {
      final uri = Uri.parse("$baseUrl/users/$uid");
      var request = http.MultipartRequest('PATCH', uri);

      // Get file extension and determine MIME type
      final extension = path.extension(imageFile.path).toLowerCase();
      String mimeType;
      switch (extension) {
        case '.jpg':
        case '.jpeg':
          mimeType = 'image/jpeg';
          break;
        case '.png':
          mimeType = 'image/png';
          break;
        case '.gif':
          mimeType = 'image/gif';
          break;
        default:
          throw Exception(
              'Unsupported image format. Please use JPG, PNG, or GIF');
      }

      // print('File path: ${imageFile.path}');
      // print('Detected MIME type: $mimeType');

      // Create multipart file with correct content type
      var multipartFile = await http.MultipartFile.fromPath(
        'imgFile',
        imageFile.path,
        contentType: MediaType.parse(mimeType),
      );
      request.files.add(multipartFile);

      // print('Multipart file added: ${multipartFile.filename}');
      // print('Content type: ${multipartFile.contentType}');

      // Add authorization header if needed
      if (token.isNotEmpty) {
        request.headers['Authorization'] = 'Bearer $token';
      }

      // print('Sending request to: $uri');
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      // print('Response status code: ${response.statusCode}');
      // print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseJson = jsonDecode(response.body);
        // Access IMAGE_URL directly from the root object
        final imageUrl = responseJson['IMAGE_URL'] as String?;
        // print('Received image URL: $imageUrl');

        if (imageUrl == null) {
          throw Exception('No image URL in response');
        }

        return imageUrl;
      } else {
        throw Exception(
            'Upload failed with status: ${response.statusCode}, message: ${response.body}');
      }
    } catch (e) {
      // print('Error uploading image: $e');
      // print('Stack trace: $stackTrace');
      throw Exception('Error uploading image: $e');
    }
  }
}
