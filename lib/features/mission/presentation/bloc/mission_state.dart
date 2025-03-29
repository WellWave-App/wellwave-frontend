part of 'mission_bloc.dart';

abstract class MissionState {
  const MissionState();

  List<Object?> get props => []; // Change to Object? in base class
}

// Initial State for Mission
class MissionInitial extends MissionState {}

// Habit Challenge State
class HabitChallengeState extends MissionState {
  final int dailyCount;
  final int minuteCount;

  HabitChallengeState({
    required this.dailyCount,
    required this.minuteCount,
  });

  @override
  List<Object?> get props => [dailyCount, minuteCount]; // Update override
}

class ProgressState extends MissionState {}

// Daily Task State

class DailyTaskState extends MissionState {
  final List<int> completedTaskIds;

  DailyTaskState({this.completedTaskIds = const []});

  @override
  List<Object?> get props => [completedTaskIds];
}

// Add new states
class HabitLoading extends MissionState {}

class HabitLoaded extends MissionState {
  final HabitRequestModel habits;
  final RecHabitResponseModel? recHabits;

  const HabitLoaded(
    this.habits,
    this.recHabits,
  );

  @override
  List<Object?> get props =>
      [habits, recHabits]; // Change to Object? for nullable values
}

class HabitError extends MissionState {
  final String message;

  const HabitError(this.message);

  @override
  List<Object> get props => [message];
}

class QuestLoading extends MissionState {}

class QuestLoaded extends MissionState {
  final QuestRequestModel quests;

  const QuestLoaded(this.quests);

  @override
  List<Object?> get props => [quests];
}

class QuestError extends MissionState {
  final String message;

  const QuestError(this.message);

  @override
  List<Object?> get props => [message];
}

class DailyTaskLoading extends MissionState {}

class DailyTaskLoaded extends MissionState {
  final GetDailyHabitModel dailyTasks;

  const DailyTaskLoaded(this.dailyTasks);

  @override
  List<Object?> get props => [dailyTasks];
}

class DailyTaskError extends MissionState {
  final String message;

  const DailyTaskError(this.message);

  @override
  List<Object?> get props => [message];
}

class HistoryLoading extends MissionState {}

class HistoryLoaded extends MissionState {
  final GetHistoryModel history;

  const HistoryLoaded(this.history);

  @override
  List<Object?> get props => [history];
}

class HistoryError extends MissionState {
  final String message;

  const HistoryError(this.message);

  @override
  List<Object?> get props => [message];
}

class GetDailyTaskLoading extends MissionState {}

class GetDailyTaskLoaded extends MissionState {
  final DailyTaskListModel getDailyTasks;

  const GetDailyTaskLoaded(this.getDailyTasks);

  @override
  List<Object?> get props => [getDailyTasks];
}

class GemsUpdating extends MissionState {}

class GemsUpdateSuccess extends MissionState {
  final int updatedAmount;

  const GemsUpdateSuccess(this.updatedAmount);
}

class GemsUpdateFailure extends MissionState {
  final String message;

  const GemsUpdateFailure(this.message);
}

// Add these states
class DailyTrackSubmitting extends MissionState {}

class DailyTrackSuccess extends MissionState {
  final int trackId;
  final HabitTrackRequestModel trackData;

  const DailyTrackSuccess({
    required this.trackId,
    required this.trackData,
  });

  @override
  List<Object> get props => [trackId, trackData];
}

// Add these states
class MoodTrackSubmitting extends MissionState {}

class MoodTrackSuccess extends MissionState {
  final HabitTrackRequestModel trackData;

  const MoodTrackSuccess(this.trackData);

  @override
  List<Object?> get props => [trackData];
}

class ActiveHabitLoaded extends MissionState {
  final Map<String, dynamic> habitData;
  final List<Map<String, dynamic>> dailyTracks;

  const ActiveHabitLoaded({
    required this.habitData,
    required this.dailyTracks,
  });

  @override
  List<Object> get props => [habitData, dailyTracks];
}

class ActiveHabitError extends MissionState {
  final String message;

  const ActiveHabitError(this.message);

  @override
  List<Object> get props => [message];
}
