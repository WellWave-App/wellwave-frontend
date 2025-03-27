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
  final int? minuteCount;
  final int hid;

  ConfirmGoalEvent({
    required this.dailyCount,
    this.minuteCount,
    required this.hid,
  });
}

class ResetGoalEvent extends MissionEvent {
  final int defaultDailyMinuteGoal;
  final int defaultDaysGoal;

  const ResetGoalEvent({
    required this.defaultDailyMinuteGoal,
    required this.defaultDaysGoal,
  });
}

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

class LoadQuestsEvent extends MissionEvent {
  @override
  List<Object?> get props => [];
}

class LoadDailyTasksEvent extends MissionEvent {
  @override
  List<Object?> get props => [];
}

class getDailyTasksEvent extends MissionEvent {
  const getDailyTasksEvent();

  @override
  List<Object?> get props => [];
}

class LoadHistoryEvent extends MissionEvent {
  final DateTime date;

  const LoadHistoryEvent(this.date);

  @override
  List<Object?> get props => [date];
}

class StartQuestEvent extends MissionEvent {
  final int questId;

  const StartQuestEvent({required this.questId});

  @override
  List<Object?> get props => [questId];
}

class LoadQuestDetailEvent extends MissionEvent {
  final int questId;

  const LoadQuestDetailEvent({required this.questId});

  @override
  List<Object?> get props => [questId];
}

class UpdateGemsEvent extends MissionEvent {
  final int gemsToAdd;

  const UpdateGemsEvent({
    required this.gemsToAdd,
  });

  @override
  List<Object> get props => [gemsToAdd];
}
