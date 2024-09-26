part of 'mission_bloc.dart';

abstract class MissionEvent {
  const MissionEvent();

  List<Object> get props => [];
}

// Habit Challenge Events
class IncrementDailyCountEvent extends MissionEvent {}

class DecrementDailyCountEvent extends MissionEvent {}

class IncrementMinuteCountEvent extends MissionEvent {
  final int incrementBy;

  IncrementMinuteCountEvent({this.incrementBy = 5});
}

class DecrementMinuteCountEvent extends MissionEvent {
  final int decrementBy;

  DecrementMinuteCountEvent({this.decrementBy = 5});
}

class ConfirmGoalEvent extends MissionEvent {
  final int dailyCount;
  final int minuteCount;

  ConfirmGoalEvent({required this.dailyCount, required this.minuteCount});
}

class ResetGoalEvent extends MissionEvent {}

// Daily Task Events
class CompleteTaskEvent extends MissionEvent {}

class EnableButtonEvent extends MissionEvent {}

class DisableButtonEvent extends MissionEvent {}