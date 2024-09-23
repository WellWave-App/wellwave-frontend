part of 'daily_task_bloc.dart';

abstract class DailyTaskState {
  List<Object> get props => [];
}

final class DailyTaskInitial extends DailyTaskState {}

class TaskInProgressState extends DailyTaskState {}

class TaskCompletedState extends DailyTaskState {}
