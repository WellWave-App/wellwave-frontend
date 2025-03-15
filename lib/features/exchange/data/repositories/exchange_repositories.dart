import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wellwave_frontend/features/exchange/data/models/exchange_request_models.dart';
import 'package:http/http.dart' as http;
import '../../../../config/constants/app_url.dart';

class ExchangeRepositories {
  final _secureStorage = const FlutterSecureStorage();

  Future<ExchangeRequestModels?> getUserItem() async {
    final token = await _secureStorage.read(key: 'access_token');
    if (token == null) {
      throw Exception("No access token found");
    }

    try {
      final response = await http.get(
        Uri.parse("$baseUrl/users/items"),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return ExchangeRequestModels.fromJson(jsonData);
      }
      return null;
    } catch (e) {
      debugPrint('Error: $e');
      return null;
    }
  }

  Future<ExchangeRequestModels?> getAllItem() async {
    final token = await _secureStorage.read(key: 'access_token');
    if (token == null) {
      throw Exception("No access token found");
    }

    try {
      final response = await http.get(
        Uri.parse("$baseUrl/shop/items"),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        debugPrint('Decoded JSON: $jsonData');

        if (jsonData is Map<String, dynamic> && jsonData.containsKey("data")) {
          final List<dynamic> itemsJson = jsonData["data"];

          if (itemsJson.isEmpty) {
            debugPrint("API returned an empty item list.");
            return null;
          }

          debugPrint("Parsed items: ${itemsJson.length}");
          return ExchangeRequestModels.fromJson({"items": itemsJson});
        }
      } else {
        debugPrint("Error: API returned status code ${response.statusCode}");
      }
      return null;
    } catch (e) {
      debugPrint('Error: $e');
      return null;
    }
  }

  Future<bool> buyItem({
    required int uid,
  }) async {
    final token = await _secureStorage.read(key: 'access_token');
    if (token == null) {
      throw Exception("No access token found");
    }

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/shop/buy-item/$uid'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 201) {
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Error: $e');
      return false;
    }
  }

  Future<Map<String, dynamic>?> openMysteryBox({
    required String boxName,
  }) async {
    final token = await _secureStorage.read(key: 'access_token');
    if (token == null) {
      throw Exception("No access token found");
    }

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/shop/mystery-box/open/$boxName'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 201) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      debugPrint('Error: $e');
      return null;
    }
  }

  Future<Object> activeItem({
    required int userItemId,
  }) async {
    final token = await _secureStorage.read(key: 'access_token');
    if (token == null) {
      throw Exception("No access token found");
    }

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users/active-item/$userItemId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 201) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      }
      return false;
    } catch (e) {
      debugPrint('Error: $e');
      return false;
    }
  }
}
