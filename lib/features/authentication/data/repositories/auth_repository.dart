import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wellwave_frontend/features/authentication/data/models/auth_model.dart';

class AuthRepository {
  final String baseUrl = 'http://localhost:3001/auth';

  // Register
  Future<bool> register(AuthModel authModel) async {
    final url = Uri.parse('$baseUrl/register');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode(authModel.toJson());

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 201) {
        debugPrint('Register Successful');
        return true;
      } else {
        debugPrint('Register Error: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      debugPrint('Register Exception: $e');
      return false;
    }
  }

  // Login
  Future<bool> login(AuthModel authModel) async {
    final url = Uri.parse('$baseUrl/login');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode(authModel.toJson());

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        debugPrint('Login Successful');
        return true;
      } else {
        debugPrint('Login Error: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      debugPrint('Login Exception: $e');
      return false;
    }
  }
}
