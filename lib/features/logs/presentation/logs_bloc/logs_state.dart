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
  final bool isDaily ;
  final bool isWeekly;

  LogsLoadSuccess({
    required this.logslist,
    this.isDaily = false,
    this.isWeekly = false,
  });
}
