import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wellwave_frontend/features/logs/data/models/logs_request_model_waistline.dart';
import 'package:wellwave_frontend/features/logs/data/models/logs_request_model_weekly.dart';
import 'package:wellwave_frontend/features/logs/data/models/logs_request_model_weight.dart';
import '../../../../config/constants/app_url.dart';
import '../../../logs/data/models/logs_request_model.dart';

class LogsRequestRepository {
  Future<bool> createLogsRequest({
    required int value,
    required String logName,
    required int uid,
    required String date,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/logs"),
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

      debugPrint(
          'Create Log Response: ${response.statusCode}, Body: ${response.body}');

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

  Future<bool> editLogsRequest({
    required num uid,
    required int value,
    required String logName,
    required String date,
  }) async {
    try {
      final response = await http.patch(
        Uri.parse("$baseUrl/logs/$uid/$logName/$date"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "VALUE": value,
        }),
      );

      debugPrint(
          'Edit Log Response: ${response.statusCode}, Body: ${response.body}');

      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Error: $e');
      return false;
    }
  }

  Future<bool> logExists({
    required String logName,
    required int uid,
    required String date,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/logs/$uid/$logName/$date'),
      );

      debugPrint(
          'Log Exists Check Response: ${response.statusCode}, Body: ${response.body}');

      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 404) {
        return false;
      }
      return false;
    } catch (e) {
      debugPrint('Error checking log existence: $e');
      return false;
    }
  }

  Future<List<LogsRequestModel?>> getLogsById(num uID, DateTime date) async {
    try {
      final response = await http.get(
        Uri.parse(
            "$baseUrl/logs/user/$uID?startDate=${date.toIso8601String()}&&endDate=${date.toIso8601String()}"),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        List<dynamic> logsJson = jsonData['LOGS'];
        debugPrint('--------------------');
        debugPrint('daily Fetched Logs: ${response.body}');
        debugPrint(
            "$baseUrl/logs/user/$uID?startDate=${date.toIso8601String()}&&endDate=${date.toIso8601String()}");
        return logsJson.map((log) => LogsRequestModel.fromJson(log)).toList();
      }
      return [];
    } catch (e) {
      debugPrint('Error: $e');
      return [];
    }
  }

  Future<List<LogsWeeklyRequestModel?>> getWeeklyLogs(
      num uID, DateTime date) async {
    try {
      final response = await http.get(
        Uri.parse(
          "$baseUrl/logs/userWeekly/$uID?date=${date.toIso8601String()}",
        ),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        List<dynamic> logsJson = jsonData['LOGS'];
        debugPrint('week Fetched Weekly Logs: ${response.body}');
        debugPrint(
            "$baseUrl/logs/userWeekly/$uID?date=${date.toIso8601String()}");
        return logsJson
            .map((log) => LogsWeeklyRequestModel.fromJson(log))
            .toList();
      }
      return [];
    } catch (e) {
      debugPrint('Error: $e');
      return [];
    }
  }

  Future<List<LogsWeightRequestModel?>> getWeightLogs(
      num uID, DateTime today) async {
    try {
      List<LogsWeightRequestModel?> logsList = [];

      // Fetch logs for the past 4 weeks, one for each week
      for (int i = 0; i < 4; i++) {
        final dateBegin = today.subtract(const Duration(days: 21));
        final DateTime targetDate =
            dateBegin.add(Duration(days: i * 7)); // 1 day per week from today
        final response = await http.get(
          Uri.parse(
            '$baseUrl/logs/userWeekly/$uID?date=${targetDate.toIso8601String()}&&logName=WEIGHT_LOG',
          ),
          headers: {
            'Content-Type': 'application/json',
          },
        );

        if (response.statusCode == 200) {
          final jsonData = jsonDecode(response.body);
          List<dynamic> logsJson = jsonData['LOGS'];
          debugPrint(
              'Filtered weight logs for week ${i + 1}: ${response.body}');
          logsList.addAll(logsJson
              .map((log) => LogsWeightRequestModel.fromJson(log))
              .toList());
        }
      }

      return logsList;
    } catch (e) {
      debugPrint('Error fetching logs: $e');
      return [];
    }
  }

  Future<List<LogsWaistLineRequestModel?>> getWaistLineLogs(
      num uID, DateTime today) async {
    try {
      List<LogsWaistLineRequestModel?> logsList = [];

      // Fetch logs for the past 4 weeks, one for each week
      for (int i = 0; i < 4; i++) {
        final dateBegin = today.subtract(const Duration(days: 21));
        final DateTime targetDate =
            dateBegin.add(Duration(days: i * 7)); // 1 day per week from today
        final response = await http.get(
          Uri.parse(
            '$baseUrl/logs/userWeekly/$uID?date=${targetDate.toIso8601String()}&&logName=WAIST_LINE_LOG',
          ),
          headers: {
            'Content-Type': 'application/json',
          },
        );

        if (response.statusCode == 200) {
          final jsonData = jsonDecode(response.body);
          List<dynamic> logsJson = jsonData['LOGS'];
          debugPrint(
              'Filtered waist line logs for week ${i + 1}: ${response.body}');
          logsList.addAll(logsJson
              .map((log) => LogsWaistLineRequestModel.fromJson(log))
              .toList());
        }
      }

      return logsList;
    } catch (e) {
      debugPrint('Error fetching logs: $e');
      return [];
    }
  }
}
