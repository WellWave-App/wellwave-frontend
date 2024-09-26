import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../logs/data/models/logs_request_model.dart';

class LogsRequestRepository {
  // Create new Logs request
  Future<bool> createLogsRequest({
    required int value,
    required String logName,
    required int uid,
    required String date,
  }) async {
    String baseUrl = 'http://10.0.2.2:3000/logs';
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "VALUE": value,
          "LOG_NAME": logName,
          "UID": uid,
          "DATE": date,
        }),
      );

      if (response.statusCode == 201) {
        debugPrint('Success: ${response.body}');
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Error: $e');
      return false;
    }
  }

  // Edit Logs request //not used
  Future<bool> editLogsRequest(String LogsId, LogsRequestModel LogsRequest,
      String isShowToEmployee) async {
    try {
      String baseUrl = 'http://localhost:3000';
      final response = await http.put(
        Uri.parse("$baseUrl/logss/$LogsId"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(LogsRequest.toEditLogsRequestJson(isShowToEmployee)),
      );

      if (response.statusCode == 200) {
        // Successfully edited
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Error: $e');
      return false;
    }
  }

  // Get a specific Logs by ID
  Future<List<LogsRequestModel?>> getLogsById(String uID, DateTime date) async {
    try {
      String baseUrl = 'http://10.0.2.2:3000';
      final response = await http.get(
        Uri.parse(
            "$baseUrl/logs/user/$uID?startDate=${date.toIso8601String()}&endDate=${date.toIso8601String()}"),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        List<dynamic> logsJson = jsonData['LOGS'];
        debugPrint('Fetched Logs: ${response.body}');
        return logsJson.map((log) => LogsRequestModel.fromJson(log)).toList();
      }
      return [];
    } catch (e) {
      debugPrint('Error: $e');
      return [];
    }
  }

  Future<List<LogsRequestModel?>> getWeeklyLogs(String uID, DateTime date) async {
  try {

    String baseUrl = 'http://10.0.2.2:3000';
    final response = await http.get(
      Uri.parse(
        "$baseUrl/logs/user/$uID?startDate=${date.toIso8601String()}",
      ),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      List<dynamic> logsJson = jsonData['LOGS'];
      debugPrint('Fetched Weekly Logs: ${response.body}');
      return logsJson.map((log) => LogsRequestModel.fromJson(log)).toList();
    }
    return [];
  } catch (e) {
    debugPrint('Error: $e');
    return [];
  }
}

}
