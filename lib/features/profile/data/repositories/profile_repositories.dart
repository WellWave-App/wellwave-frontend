import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:http_parser/http_parser.dart';

import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/profile/data/models/profile_request_model.dart';

import '../../../../config/constants/app_url.dart';

class ProfileRepositories {
  final _secureStorage = const FlutterSecureStorage();
=======
import 'package:http/http.dart' as http;
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/profile/data/models/profile_request_model.dart';

class ProfileRepositories {
  String baseUrl = AppStrings.baseUrl;
  String token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJFTUFJTCI6InVzZXIxQGV4YW1wbGUuY29tIiwiVUlEIjoyLCJpYXQiOjE3MzgzMTAxNDMsImV4cCI6MTczODM5NjU0M30.bDGjnK2_YktPQ3fYgLdehlqzfg6PeYItXMrOZYKhfqw';
>>>>>>> 2a4b6a782119ad442510a02e8dcabc1f303062c2

  Future<bool> editUserRequest({
    required int uid,
    required String imageUrl,
    required String username,
    required int yearOfBirth,
    required bool gender,
    required num height,
    required num weight,
<<<<<<< HEAD
    int? gem,
  }) async {
    final token = await _secureStorage.read(key: 'access_token');
    if (token == null) {
      throw Exception("No access token found");
    }
=======
  }) async {
>>>>>>> 2a4b6a782119ad442510a02e8dcabc1f303062c2
    try {
      final uri = Uri.parse("$baseUrl/users/$uid");

      final Map<String, String> userDetails = {
        'USERNAME': username,
        'YEAR_OF_BIRTH': yearOfBirth.toString(),
        'GENDER': gender.toString(),
        'HEIGHT': height.toString(),
        'WEIGHT': weight.toString(),
        'IMAGE_URL': imageUrl,
<<<<<<< HEAD
        'GEM': gem?.toString() ?? AppStrings.emptyText,
=======
>>>>>>> 2a4b6a782119ad442510a02e8dcabc1f303062c2
      };

      final request = http.MultipartRequest('PATCH', uri)
        ..headers['Authorization'] = 'Bearer $token'
        ..fields.addAll(userDetails);

<<<<<<< HEAD
      final response = await request.send();

      debugPrint('Edit Profile: ${response.statusCode}');
=======
      // request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      debugPrint('Edit Profile: ${response.statusCode}');
      debugPrint('Response Body: $responseBody');
>>>>>>> 2a4b6a782119ad442510a02e8dcabc1f303062c2

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
<<<<<<< HEAD
    final token = await _secureStorage.read(key: 'access_token');
    if (token == null) {
      throw Exception("No access token found");
    }
=======
>>>>>>> 2a4b6a782119ad442510a02e8dcabc1f303062c2
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
<<<<<<< HEAD
    final token = await _secureStorage.read(key: 'access_token');
    if (token == null) {
      throw Exception("No access token found");
    }
=======
>>>>>>> 2a4b6a782119ad442510a02e8dcabc1f303062c2
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

<<<<<<< HEAD
  Future<String?> uploadProfileImage(File imageFile, int uid) async {
    final token = await _secureStorage.read(key: 'access_token');
    if (token == null) {
      throw Exception("No access token found");
    }
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

      // Create multipart file with correct content type
      var multipartFile = await http.MultipartFile.fromPath(
        'imgFile',
        imageFile.path,
        contentType: MediaType.parse(mimeType),
      );
      request.files.add(multipartFile);

      // Add authorization header if needed
      if (token.isNotEmpty) {
        request.headers['Authorization'] = 'Bearer $token';
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final responseJson = jsonDecode(response.body);
        // Access IMAGE_URL directly from the root object
        final imageUrl = responseJson['IMAGE_URL'] as String?;

        if (imageUrl == null) {
          throw Exception('No image URL in response');
        }

        return imageUrl;
      } else {
        throw Exception(
            'Upload failed with status: ${response.statusCode}, message: ${response.body}');
=======
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
>>>>>>> 2a4b6a782119ad442510a02e8dcabc1f303062c2
      }
    } catch (e) {
      throw Exception('Error uploading image: $e');
    }
  }
<<<<<<< HEAD

  Future<bool> createCheckInResponse({
    required String date,
  }) async {
    final token = await _secureStorage.read(key: 'access_token');
    if (token == null) {
      throw Exception("No access token found");
    }
    try {
      final uri = Uri.parse("$baseUrl/checkin-challenge/check");

      // Create the JSON body
      final Map<String, String> body = {
        'DATE': date,
      };

      // Log complete request details
      // debugPrint('CheckIn Request URL: $uri');
      // debugPrint('CheckIn Request Body: ${jsonEncode(body)}');

      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      // debugPrint('CheckIn Request Headers: $headers');

      final response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );

      // Log complete response details
      // debugPrint('CheckIn Response Status Code: ${response.statusCode}');
      // debugPrint('CheckIn Response Headers: ${response.headers}');
      // debugPrint('CheckIn Response Body: ${response.body}');

      if (response.statusCode == 201) {
        return true;
      } else {
        // Try to parse error response if possible
        try {
          final errorBody = jsonDecode(response.body);
          debugPrint('Parsed Error Response: $errorBody');
        } catch (e) {
          debugPrint('Could not parse error response: $e');
        }

        throw Exception(
            'Failed to checkIn. Status code: ${response.statusCode}. Response: ${response.body}');
      }
    } catch (e) {
      debugPrint('CheckIn Error: $e');
      rethrow;
    }
  }
=======
>>>>>>> 2a4b6a782119ad442510a02e8dcabc1f303062c2
}
