import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wellwave_frontend/features/profile/data/models/drink_plan_notification_response_model.dart';
import 'package:wellwave_frontend/features/profile/data/models/drink_range_notification_response_model.dart';
import 'package:wellwave_frontend/features/profile/data/models/sleep_notification_response_model.dart';

import '../../../../config/constants/app_strings.dart';

class NotificationSettingRepository {
  final String baseUrl = '${AppStrings.baseUrl}/noti-setting';
  String token = AppStrings.token;

  Future<bool> createBedSetting({
    required int uid,
    required bool isActive,
    required String bedtime,
    required Map<String, bool> weekdays,
  }) async {
    final body = {
      "UID": uid,
      "IS_ACTIVE": isActive,
      "BEDTIME": bedtime,
      "WEEKDAYS": weekdays,
    };

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/set-bed-time'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppStrings.token}',
        },
        body: jsonEncode(body),
      );

      // debugPrint('Response Body: ${response.body}');
      // debugPrint('Payload: ${jsonEncode(body)}');

      if (response.statusCode == 201) {
        debugPrint(
            'Bedtime setting created successfully for $uid, $isActive, $bedtime,$weekdays');
        return true;
      } else {
        debugPrint('Failed to update bedtime setting: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      debugPrint('Error updating bedtime setting: $error');
      return false;
    }
  }

  Future<SleepNotificationResponseModel?> fetchBedSetting() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/get-noti/BEDTIME'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppStrings.token}',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        final isActive = jsonData['IS_ACTIVE'];
        final bedtimeSettings = jsonData['bedtimeSettings'];

        if (bedtimeSettings != null) {
          final bedtime = bedtimeSettings['BEDTIME'];
          final weekdays =
              Map<String, bool>.from(bedtimeSettings['WEEKDAYS'] ?? {});

          debugPrint(
              'Fetched Data: isActive = $isActive, bedtime = $bedtime, weekdays = $weekdays');

          return SleepNotificationResponseModel(
            isActive: isActive,
            setting: SettingDetail(
              bedtime: bedtime,
              weekdays: weekdays,
            ),
          );
        } else {
          debugPrint('Error: bedtimeSettings was null');
        }
      } else {
        debugPrint(
            'Error: Server returned non-200 status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
    return null;
  }

  Future<bool> updateBedSetting({
    required int uid,
    required bool isActive,
  }) async {
    final body = {
      "UID": uid,
      "IS_ACTIVE": isActive,
    };

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/set-bed-time'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppStrings.token}',
        },
        body: jsonEncode(body),
      );

      // debugPrint('Response Body: ${response.body}');
      // debugPrint('Payload: ${jsonEncode(body)}');

      if (response.statusCode == 201) {
        debugPrint('Bedtime setting created successfully for $uid, $isActive');
        return true;
      } else {
        debugPrint('Failed to update bedtime setting: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      debugPrint('Error updating bedtime setting: $error');
      return false;
    }
  }

  Future<bool> createDrinkPlanSetting({
    required int uid,
    required int glassNumber,
    required String notitime,
  }) async {
    final body = {
      "UID": uid,
      "GLASS_NUMBER": glassNumber,
      "NOTI_TIME": notitime
    };

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/set-water-plan'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppStrings.token}',
        },
        body: jsonEncode(body),
      );

      // debugPrint('Response Body: ${response.body}');
      // debugPrint('Payload: ${jsonEncode(body)}');

      if (response.statusCode == 201) {
        debugPrint(
            'Drink plan setting created successfully for $uid, $notitime, $glassNumber');
        return true;
      } else {
        debugPrint(
            'Failed to create Drink plan  setting: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      debugPrint('Error create Drink plan  setting: $error');
      return false;
    }
  }

  Future<DrinkPlanNotificationResponseModel?> fetchDrinkPlanSetting() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/get-noti/WATER_PLAN'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppStrings.token}',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        final isActive = jsonData['IS_ACTIVE'] as bool? ?? false;

        if (isActive) {
          final settings = jsonData['waterPlanSetting'] as List<dynamic>?;

          if (settings != null) {
            final settingDetails = settings
                .map((e) =>
                    DrinkSettingDetail.fromJson(e as Map<String, dynamic>))
                .toList();

            debugPrint('repo Fetched Data: isActive = $isActive');
            for (var setting in settingDetails) {
              debugPrint('Setting Detail: ${setting.toJson()}');
            }

            return DrinkPlanNotificationResponseModel(
              settingType: jsonData['settingType'] ?? 'WATER_PLAN',
              isActive: isActive,
              setting: settingDetails,
            );
          } else {
            debugPrint('No settings found in response.');
          }
        } else {
          debugPrint('IS_ACTIVE was false.');
        }
      } else {
        debugPrint(
            'Error: Server returned non-200 status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
    return null;
  }

  Future<bool> updateDrinkPlanSetting({
    required int uid,
    required bool isActive,
  }) async {
    final body = {
      "UID": uid,
      "IS_ACTIVE": isActive,
    };

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/set-water-plan'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppStrings.token}',
        },
        body: jsonEncode(body),
      );

      // debugPrint('Response Body: ${response.body}');
      // debugPrint('Payload: ${jsonEncode(body)}');

      if (response.statusCode == 201) {
        debugPrint(
            'DrinkPlan setting created successfully for $uid, $isActive');
        return true;
      } else {
        debugPrint(
            'Failed to update DrinkPlan setting: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      debugPrint('Error updating DrinkPlan setting: $error');
      return false;
    }
  }

  Future<bool> createDrinkRangeSetting({
    required int uid,
    required String startTime,
    required String endTime,
    required int intervalMinute,
  }) async {
    final body = {
      "UID": uid,
      "START_TIME": startTime,
      "END_TIME": endTime,
      "INTERVAL_MINUTES": intervalMinute
    };

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/set-water-range'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppStrings.token}',
        },
        body: jsonEncode(body),
      );

      // debugPrint('Response Body: ${response.body}');
      // debugPrint('Payload: ${jsonEncode(body)}');

      if (response.statusCode == 201) {
        debugPrint(
            'Drink Range setting created successfully for $uid, $startTime, $endTime , $intervalMinute');
        return true;
      } else {
        debugPrint(
            'Failed to create Drink Range  setting: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      debugPrint('Error create Drink Range  setting: $error');
      return false;
    }
  }

  Future<DrinkRangeNotificationResponseModel?> fetchDrinkRangeSetting() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/get-noti/WATER_RANGE'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppStrings.token}',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        final isActive = jsonData['IS_ACTIVE'];

        final startTime = jsonData['waterRangeSettings'] != null
            ? jsonData['waterRangeSettings']['START_TIME']
            : null;
        final endTime = jsonData['waterRangeSettings'] != null
            ? jsonData['waterRangeSettings']['END_TIME']
            : null;

        final intervalMinute = jsonData['waterRangeSettings'] != null
            ? jsonData['waterRangeSettings']['INTERVAL_MINUTES']
            : null;

        debugPrint(
            'Fetched Data: isActive = $isActive, $startTime, $endTime , $intervalMinute');

        return DrinkRangeNotificationResponseModel(
          isActive: isActive,
          setting: DrinkRangeSettingDetail(
              startTime: startTime,
              endTime: endTime,
              intervalMinute: intervalMinute),
        );
      } else {
        debugPrint(
            'Error: Server returned non-200 status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
    return null;
  }

  Future<bool> updateDrinkRangeSetting({
    required int uid,
    required bool isActive,
  }) async {
    final body = {
      "UID": uid,
      "IS_ACTIVE": isActive,
    };

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/set-water-range'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppStrings.token}',
        },
        body: jsonEncode(body),
      );

      // debugPrint('Response Body: ${response.body}');
      // debugPrint('Payload: ${jsonEncode(body)}');

      if (response.statusCode == 201) {
        debugPrint(
            'Drink Range setting created successfully for $uid, $isActive');
        return true;
      } else {
        debugPrint(
            'Failed to update Drink Rangesetting: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      debugPrint('Error updating Drink Range setting: $error');
      return false;
    }
  }
}
