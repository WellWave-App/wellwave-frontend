part of 'logs_bloc.dart';

sealed class LogsEvent {}

class LogsFetched extends LogsEvent{
  final DateTime date;
  LogsFetched({required this.date});
}

class LogsFetchedWeekly extends LogsEvent{
  final DateTime date;
  LogsFetchedWeekly({required this.date});
}

class LogsFetchedWeight extends LogsEvent{
  final DateTime date;
  LogsFetchedWeight({required this.date});
}

class LogsFetchedWaistLine extends LogsEvent{
  final DateTime date;
  LogsFetchedWaistLine({required this.date});
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

