import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wellwave_frontend/features/health_assessment/data/models/health_assessment_health_data_request_model.dart';
import 'package:wellwave_frontend/features/health_assessment/data/models/health_assessment_personal_data_request_model.dart';

class HealthAssessmentRepository {
  HealthAssessmentRepository();

  String baseUrl = 'http://10.0.2.2:3000';
  Future<bool> sendHealthAssessmentHealthData(
      HealthAssessmentHealthDataRequestModel model) async {
    // ใช้ baseUrl ที่ถูกส่งเข้ามาแทนการฮาร์ดโค้ด URL
    final url = Uri.parse('$baseUrl/risk-assessment/');
    final body = jsonEncode(model.toJson());

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        debugPrint('Failed to send data: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      debugPrint('Error sending data: $e');
      return false;
    }
  }

  Future<bool> sendHealthAssessmentPersonalData(
      HealthAssessmentPersonalDataRequestModel model) async {
    // ใช้ baseUrl ที่ถูกส่งเข้ามาแทนการฮาร์ดโค้ด URL
    final url = Uri.parse('$baseUrl/users');
    final body = jsonEncode(model.toJson());
    debugPrint('Sending request to $url');
    debugPrint('Request body: $body');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 201) {
        debugPrint('Success: ${response.body}');
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Error sending data: $e');
      return false;
    }
  }
}
