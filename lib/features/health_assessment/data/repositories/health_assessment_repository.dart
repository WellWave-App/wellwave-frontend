import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wellwave_frontend/features/health_assessment/data/models/health_assessment_response_model.dart';

class HealthAssessmentRepository {
  final http.Client client;

  HealthAssessmentRepository({required this.client});

  // Fetch health assessment data from an API
  Future<HealthAssessmentResponseModel> fetchHealthAssessment(
      String userId) async {
    try {
      final response = await client.get(
        Uri.https('example.com', '/health/$userId'),
      );

      if (response.statusCode == 200) {
        // Convert JSON response to a HealthAssessmentResponseModel
        return HealthAssessmentResponseModel.fromJson(response.body);
      } else {
        throw Exception('Failed to load health assessment');
      }
    } catch (e) {
      // Handle exceptions
      throw Exception('Error fetching health data: $e');
    }
  }

  // Example method to post updated health assessment data
  Future<void> updateHealthAssessment(
      HealthAssessmentResponseModel model) async {
    try {
      final response = await client.post(
        Uri.https('example.com', '/health/update'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: model.toJson(),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update health assessment');
      }
    } catch (e) {
      throw Exception('Error updating health data: $e');
    }
  }
}
