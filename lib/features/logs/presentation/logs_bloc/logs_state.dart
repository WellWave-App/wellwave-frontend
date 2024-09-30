part of 'logs_bloc.dart';

sealed class LogsState {}

final class LogsInitial extends LogsState {}

class LogsLoadInProgress extends LogsState {}

class LogsError extends LogsState {
  final String message;

  LogsError({required this.message});
}

class LogsLoadSuccess extends LogsState {
  final List<LogsRequestModel?> logslist;
  final List<LogsWeeklyRequestModel?> logsWeeklyList;

  LogsLoadSuccess({
    required this.logslist,
    required this.logsWeeklyList,
  });
}



class LogsLoadGraphSuccess extends LogsState {

  final List<LogsWeightRequestModel?> logsGraphlist;

  LogsLoadGraphSuccess({
    required this.logsGraphlist,
  });
}

