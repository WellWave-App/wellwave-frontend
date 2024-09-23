part of 'daily_task_bloc.dart';

abstract class DailyTaskEvent {
  List<Object> get props => [];
}

class CompleteTaskEvent extends DailyTaskEvent {}

