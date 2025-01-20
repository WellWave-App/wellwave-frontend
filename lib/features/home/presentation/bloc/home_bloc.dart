import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class NavigateToProfileScreenEvent extends HomeEvent {}

class NavigationToProfileScreenState extends HomeState {}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<NavigateToProfileScreenEvent>((event, emit) {
      emit(NavigationToProfileScreenState());
    });

    on<UpdateHealthDataEvent>((event, emit) {
      List<int> weeklyAverages = calculateWeeklyAverages(event.newData);
      debugPrint("UpdateHealthDataEvent");
      emit(HomeLoadedState(weeklyAverages));
    });
  }
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
