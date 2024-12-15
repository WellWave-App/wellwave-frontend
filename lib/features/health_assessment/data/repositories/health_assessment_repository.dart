import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wellwave_frontend/features/health_assessment/data/models/health_assessment_health_data_request_model.dart';
import 'package:wellwave_frontend/features/health_assessment/data/models/health_assessment_personal_data_request_model.dart';

class HealthAssessmentRepository {
  HealthAssessmentRepository();

  String baseUrl = 'http://10.0.2.2:3000';
  String userID = '3';

  Future<bool> sendHealthAssessmentPersonalData(
      HealthAssessmentPersonalDataRequestModel model) async {
    final url = Uri.parse('$baseUrl/users/$userID');
    final body = jsonEncode(model.toJson());
    debugPrint('Sending request to $url');
    debugPrint('Request body: $body');

    try {
      final response = await http.patch(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        userID = responseData['UID'].toString();
        debugPrint('Success: ${response.body}');
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

  Future<bool> sendHealthAssessmentHealthData(
      HealthAssessmentHealthDataRequestModel model) async {
    final url = Uri.parse('$baseUrl/risk-assessment/$userID');
    final body = jsonEncode(model.toJson());

    debugPrint('Sending POST request to: $url');
    debugPrint('Request body: $body');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 201) {
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
