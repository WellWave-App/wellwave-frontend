part of 'mission_bloc.dart';

abstract class MissionState {
  const MissionState();

  List<Object> get props => [];
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
  List<Object> get props => [dailyCount, minuteCount];
}

// Daily Task State
class TaskCompletedState extends MissionState {}

class TaskInProgressState extends MissionState {}
