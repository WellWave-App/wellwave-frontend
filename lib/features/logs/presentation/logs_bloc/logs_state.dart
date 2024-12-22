part of 'logs_bloc.dart';

sealed class LogsState {}

final class LogsInitial extends LogsState {}

class LogsLoadInProgress extends LogsState {}

class LogsLoadGraphInProgress extends LogsState {}

class LogsError extends LogsState {
  final String message;

  LogsError({required this.message});
}

class LogsLoadSuccess extends LogsState {
  final List<LogsRequestModel?> logslist;
  final List<LogsWeeklyRequestModel?> logsWeeklyList;
  final List<LogsWeeklyRequestModel?> logsLastWeekList;

  LogsLoadSuccess({
    required this.logslist,
    required this.logsWeeklyList,
    this.logsLastWeekList = const [],
  });
}

class LogsLoadGraphSuccess extends LogsState {
  final List<LogsWeightRequestModel?> logsWeightlist;
  final List<LogsWaistLineRequestModel?> logsWaistLinelist;

  LogsLoadGraphSuccess({
    required this.logsWeightlist,
    required this.logsWaistLinelist,
  });
}
