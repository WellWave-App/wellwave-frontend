import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:wellwave_frontend/features/home/data/models/notifications.dart';
import 'package:wellwave_frontend/features/home/widget/mockup_data/notification_data.dart';

part 'home_event.dart';
part 'home_state.dart';

// class NavigateToProfileScreenEvent extends HomeEvent {}

// class NavigationToProfileScreenState extends HomeState {}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final DateTime currentDate;
  final Map<String, Map<DateTime, bool>> completionStatus = {};
  List<Notifications> notificationsList =
      getMockNotificationsData(); // เพิ่ม notificationsList

  HomeBloc({required this.currentDate}) : super(HomeInitial()) {
    on<UpdateCompletionStatusEvent>((event, emit) {
      try {
        if (!completionStatus.containsKey(event.progressId)) {
          completionStatus[event.progressId] = {};
        }

        final currentStatus =
            completionStatus[event.progressId]?[event.date] ?? false;
        if (currentStatus != event.isComplete) {
          completionStatus[event.progressId]![event.date] = event.isComplete;
          emit(HomeUpdated(completionStatus: completionStatus));
          debugPrint('dailyCompletion: ${completionStatus[event.progressId]}');
        }

        _checkExpiredDates(DateTime.now(), completionStatus);
      } catch (e) {
        emit(HomeErrorState('Error updating completion status: $e'));
      }
    });
    on<NavigatorToNotificationPage>((event, emit) {
      emit(NavigateToNotificationState(event.route)); // Emit state เพื่อนำทาง
    });

    on<UpdateHealthDataEvent>((event, emit) {
      List<int> weeklyAverages = calculateWeeklyAverages(event.newData);
      debugPrint("UpdateHealthDataEvent");
      emit(HomeLoadedState(weeklyAverages));
    });

    // จัดการ MarkNotificationAsReadEvent
    on<MarkNotificationAsReadEvent>((event, emit) {
      try {
        final notification = notificationsList.firstWhere(
          (n) => n.id == event.notificationId,
        );
        notification.isRead = true; // อัพเดท isRead เป็น true
        emit(NotificationMarkedAsReadState(
            event.notificationId)); // Emit state ใหม่
      } catch (e) {
        emit(HomeErrorState('Error marking notification as read: $e'));
      }
    });
  }

  List<int> calculateWeeklyAverages(List<Map<String, dynamic>> data) {
    List<int> weeklyAverages = [];
    int weekSum = 0;
    int dayCount = 0;

    for (int i = 0; i < data.length; i++) {
      int value = data[i]['value'] as int;

      weekSum += value;
      dayCount++;

      if (dayCount == 7 || i == data.length - 1) {
        int average = (weekSum / dayCount).round();
        weeklyAverages.add(average);

        weekSum = 0;
        dayCount = 0;
      }
    }

    return weeklyAverages;
  }

  String generateDailyText() {
    final messages = [
      'ทุกก้าวเล็ก ๆ ที่ทำสำคัญเสมอ!',
      'ไม่มีอะไรที่เราทำไม่ได้!',
      'ความสำเร็จเริ่มจากก้าวแรก!',
      'ทุกก้าวคือความสำเร็จ!',
      'พยายามต่อไป ไม่มีคำว่าแพ้!',
      'พัฒนาตัวเองทุกวัน!',
      'สู้ต่อไป อย่าหยุดพัฒนา!',
    ];

    final now = DateTime.now();
    final seed = now.year * 10000 + now.month * 100 + now.day;
    final random = Random(seed);

    return messages[random.nextInt(messages.length)];
  }

  String generateGreeting() {
    final now = DateTime.now();
    final hour = now.hour;

    String greeting;
    if (hour >= 5 && hour < 12) {
      greeting = "อรุณสวัสดิ์";
    } else if (hour >= 12 && hour < 18) {
      greeting = "สวัสดีตอนบ่าย";
    } else {
      greeting = "สวัสดีตอนเย็น";
    }

    return greeting;
  }

  void _checkExpiredDates(
      DateTime now, Map<String, Map<DateTime, bool>> completionStatus) {
    for (final entry in completionStatus.entries) {
      final progressId = entry.key;
      final dates = entry.value;

      for (final dateEntry in dates.entries) {
        final date = dateEntry.key;
        final isComplete = dateEntry.value;

        // ตรวจสอบว่าวันที่หมดอายุหรือไม่ (วันที่ผ่านไปแล้ว)
        if (date.isBefore(now) && isComplete == null) {
          completionStatus[progressId]![date] = false;
        }
      }
    }
  }
}
