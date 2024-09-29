import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wellwave_frontend/features/health_assessment/data/models/health_assessment_health_data_request_model.dart';

class HealthAssessmentRepository {
  final String baseUrl;

  HealthAssessmentRepository({required this.baseUrl});

  Future<bool> sendHealthAssessmentData(
      HealthAssessmentHealthDataRequestModel model) async {
    final url = Uri.parse('$baseUrl/api/health-assessment');
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
}
