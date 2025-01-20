part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class UpdateHealthDataEvent extends HomeEvent {
  final List<Map<String, dynamic>> newData;

  UpdateHealthDataEvent(this.newData);
}

class CalculateWeeklyAveragesEvent extends HomeEvent {
  final List<Map<String, dynamic>> data;

  CalculateWeeklyAveragesEvent(this.data);
}

class GenerateGreetingTextEvent extends HomeEvent {}
