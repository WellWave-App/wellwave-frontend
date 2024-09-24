part of 'logs_bloc.dart';

sealed class LogsEvent {}
class LogsFetched extends LogsEvent{}
class WaterRecordClicked extends LogsEvent{}
class SleepRecordClicked extends LogsEvent{}
class WeeklyRecordClicked extends LogsEvent{}

