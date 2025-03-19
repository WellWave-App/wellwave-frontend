import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wellwave_frontend/features/exchange/data/models/exchange_response_models.dart';
import 'package:http/http.dart' as http;
import '../../../../config/constants/app_url.dart';

class ExchangeRepositories {
  final _secureStorage = const FlutterSecureStorage();

  Future<ExchangeResponseModels?> getUserItem() async {
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

        if (jsonData is Map<String, dynamic> && jsonData.containsKey("data")) {
          final List<dynamic> itemsJson = jsonData["data"];

          if (itemsJson.isEmpty) {
            debugPrint("API returned an empty item list.");
            return null;
          }

          debugPrint("Original items count: ${itemsJson.length}");

          // IMPORTANT: Don't restructure the data - use it as is
          // The API is already sending the correct structure
          return ExchangeResponseModels.fromJson({"items": itemsJson});
        }
      }
      debugPrint("Error: API returned status code ${response.statusCode}");
      return null;
    } catch (e) {
      debugPrint('Error: $e');
      return null;
    }
  }

  Future<ExchangeResponseModels?> getAllItem() async {
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
      // debugPrint('Response status: ${response.statusCode}');
      // debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        // debugPrint('Decoded JSON: $jsonData');

        if (jsonData is Map<String, dynamic> && jsonData.containsKey("data")) {
          final List<dynamic> itemsJson = jsonData["data"];

          if (itemsJson.isEmpty) {
            debugPrint("API returned an empty item list.");
            return null;
          }

          debugPrint("Original items count: ${itemsJson.length}");

          // Create exchange response items with proper structure
          final List<Map<String, dynamic>> exchangeItems =
              itemsJson.map((item) {
            // In the actual API response, we don't have USER_ITEM_ID, UID, etc.
            // So we'll use the item ID as a fallback for these fields
            return {
              'USER_ITEM_ID': item['ITEM_ID'] ?? 0,
              'UID': 5,
              'ITEM_ID': item['ITEM_ID'] ?? 0,
              'PURCHASE_DATE': DateTime.now().toIso8601String(),
              'EXPIRE_DATE': null,
              'IS_ACTIVE': true,
              'item': item,
            };
          }).toList();

          // debugPrint("Processed exchangeItems: ${exchangeItems.length}");

          // // Debug the first item to verify structure
          // if (exchangeItems.isNotEmpty) {
          //   debugPrint("First item sample: ${exchangeItems[0]}");
          //   debugPrint("Item data in first item: ${exchangeItems[0]['item']}");
          // }

          return ExchangeResponseModels.fromJson({"items": exchangeItems});
        }
      }
      debugPrint("Error: API returned status code ${response.statusCode}");
      return null;
    } catch (e) {
      debugPrint('Error: $e');
      return null;
    }
  }

  Future<Object> buyItem({
    required int itemId,
  }) async {
    final token = await _secureStorage.read(key: 'access_token');
    if (token == null) {
      throw Exception("No access token found");
    }

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/shop/buy-item/$itemId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      }
      return false;
    } catch (e) {
      debugPrint('Error: $e');
      return false;
    }
  }

  Future<Object> openMysteryBox({
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
      return false;
    } catch (e) {
      debugPrint('Error: $e');
      return false;
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
