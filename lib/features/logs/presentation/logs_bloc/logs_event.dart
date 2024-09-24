part of 'logs_bloc.dart';

sealed class LogsEvent {}
class LogsFetched extends LogsEvent{
  final DateTime date;

  LogsFetched({required this.date});

}
class WaterRecordClicked extends LogsEvent{}
class SleepRecordClicked extends LogsEvent{}
class WeeklyRecordClicked extends LogsEvent{}

