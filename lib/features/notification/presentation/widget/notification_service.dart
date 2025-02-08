import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/material.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() {
    return _instance;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void scheduleBedtimeNotifications(Map<String, dynamic> bedtimeSettings) {
    // Parse bedtime time
    String bedtimeTime = bedtimeSettings['BEDTIME'];
    List<String> timeParts = bedtimeTime.split(':');
    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1]);

    // Parse weekdays
    Map<String, bool> weekdays = bedtimeSettings['WEEKDAYS'];

    // Get the current date and time
    DateTime now = DateTime.now();

    // Loop through each day of the week
    weekdays.forEach((day, isEnabled) {
      if (isEnabled) {
        // Find the next occurrence of this day
        DateTime nextDay = _findNextDay(day, now);

        // Set the time for the notification
        DateTime scheduledTime = DateTime(
          nextDay.year,
          nextDay.month,
          nextDay.day,
          hour,
          minute,
        );

        // Schedule the notification
        NotificationService().scheduleDailyNotification(scheduledTime);
      }
    });
  }

  DateTime _findNextDay(String day, DateTime now) {
    // Map days to their respective indices (Sunday = 0, Monday = 1, etc.)
    Map<String, int> dayIndices = {
      'Sunday': 7,
      'Monday': 1,
      'Tuesday': 2,
      'Wednesday': 3,
      'Thursday': 4,
      'Friday': 5,
      'Saturday': 6,
    };

    int currentDayIndex = now.weekday;
    int targetDayIndex = dayIndices[day]!;

    // Calculate the difference in days
    int daysToAdd = (targetDayIndex - currentDayIndex + 7) % 7;
    if (daysToAdd == 0) {
      daysToAdd = 7; // Schedule for the same day next week
    }

    return now.add(Duration(days: daysToAdd));
  }

  Future<void> init() async {
    tz.initializeTimeZones(); // Initialize the timezone database

    // Get the current timezone offset (e.g., "+07")
    final String currentTimeZoneOffset = DateTime.now().timeZoneName;

    // Map the offset to a valid IANA timezone
    final String? ianaTimeZone = _getIanaTimeZone(currentTimeZoneOffset);

    if (ianaTimeZone != null) {
      tz.setLocalLocation(tz.getLocation(ianaTimeZone));
    } else {
      // Fallback to a default timezone if the offset cannot be mapped
      tz.setLocalLocation(tz.getLocation('UTC'));
    }

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        if (response.payload != null) {
          debugPrint('notification payload: ${response.payload}');
        }
      },
    );
  }

// Helper method to map timezone offset to IANA timezone
  String? _getIanaTimeZone(String offset) {
    // Map common offsets to IANA timezones
    final Map<String, String> offsetToIana = {
      '+07': 'Asia/Bangkok', // Example: Thailand
      '+08': 'Asia/Singapore', // Example: Singapore
      '+00': 'UTC', // UTC
      '+01': 'Europe/London', // Example: London
      '-05': 'America/New_York', // Example: New York
      // Add more mappings as needed
    };

    return offsetToIana[offset];
  }

  Future<void> scheduleDailyNotification(DateTime selectedTime) async {
    if (selectedTime.isBefore(DateTime.now())) {
      selectedTime = selectedTime.add(const Duration(days: 1));
    }
    final tz.TZDateTime scheduledTime =
        tz.TZDateTime.from(selectedTime, tz.local);

    try {
      await _notificationsPlugin.zonedSchedule(
        0,
        "notification title",
        "notification body",
        scheduledTime,
        _notificationDetails(),
        // androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );

      debugPrint('Notification scheduled successfully');
    } catch (e) {
      debugPrint('Error scheduling notification: $e');
    }
  }

  NotificationDetails _notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'your_channel_id',
        'your_channel_name',
        channelDescription: 'your_channel_description',
        importance: Importance.max,
        priority: Priority.high,
        showWhen: false,
      ),
    );
  }
}
