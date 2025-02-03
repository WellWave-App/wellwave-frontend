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

class UpdateCompletionStatusEvent extends HomeEvent {
  final String progressId;
  final DateTime date;
  final bool isComplete;

  UpdateCompletionStatusEvent({
    required this.progressId,
    required this.date,
    required this.isComplete,
  });
}

class LoadNotificationsEvent extends HomeEvent {}

class MarkNotificationAsReadEvent extends HomeEvent {
  final String notificationId;

  MarkNotificationAsReadEvent(this.notificationId);
}
