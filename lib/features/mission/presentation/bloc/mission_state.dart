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
  List<Object?> get props => [completedTaskIds]; // Update override
}

// Add new states
class HabitLoading extends MissionState {}

class HabitLoaded extends MissionState {
  final HabitRequestModel habits;
  final RecHabitResponseModel? recHabits; // Make this nullable

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
