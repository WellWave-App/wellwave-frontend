part of 'logs_bloc.dart';

sealed class LogsEvent {}

class LogsFetched extends LogsEvent {
  final DateTime date;

  LogsFetched(this.date);
}

class LogsFetchedGraph extends LogsEvent {
  final DateTime date;

  LogsFetchedGraph(this.date);
}

// class LogsFetchedWeight extends LogsEvent{
//   final DateTime date;
//   LogsFetchedWeight({required this.date});
// }

// class LogsFetchedWaistLine extends LogsEvent{
//   final DateTime date;
//   LogsFetchedWaistLine({required this.date});
// }


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
