part of 'logs_bloc.dart';

sealed class LogsEvent {}

class LogsFetched extends LogsEvent{
  final DateTime date;
  LogsFetched({required this.date});
}

class SubmitLogEvent extends LogsEvent {
  final String logName;
  final int value;
  final String selectedDate;

  SubmitLogEvent({
    required this.logName,
    required this.value,
    required this.selectedDate,
  });
}

