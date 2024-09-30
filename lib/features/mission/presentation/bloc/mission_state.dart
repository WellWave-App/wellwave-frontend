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

class ProgressState extends MissionState {} 

// Daily Task State

class DailyTaskState extends MissionState {
  final List<int> completedTaskIds; 

  DailyTaskState({this.completedTaskIds = const []});

  @override
  List<Object> get props => [completedTaskIds];
}

