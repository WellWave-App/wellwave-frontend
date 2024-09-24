part of 'mission_bloc.dart';


abstract class MissionEvent {
  const MissionEvent();

  List<Object> get props => [];
}


// Habit Challenge Events
class IncrementDailyCount extends MissionEvent {}

class DecrementDailyCount extends MissionEvent {}

class IncrementMinuteCount extends MissionEvent {}

class DecrementMinuteCount extends MissionEvent {}

// Daily Task Events
class CompleteTaskEvent extends MissionEvent {}
