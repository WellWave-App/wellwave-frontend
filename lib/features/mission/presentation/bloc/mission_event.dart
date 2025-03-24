part of 'mission_bloc.dart';

abstract class MissionEvent {
  const MissionEvent();

  List<Object?> get props => [];
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

class StartProgressEvent extends MissionEvent {}

// Daily Task Events
class CompleteTaskEvent extends MissionEvent {
  final int taskId;

  CompleteTaskEvent(this.taskId);

  @override
  List<Object> get props => [taskId];
}

class LoadHabitsEvent extends MissionEvent {
  final String? category;

  const LoadHabitsEvent({this.category});

  @override
  List<Object?> get props => [category];
}

class LoadRecHabitsEvent extends MissionEvent {
  @override
  List<Object?> get props => [];
}
