part of 'logs_bloc.dart';

sealed class LogsState {}

final class LogsInitial extends LogsState {}

class LogsLoadInProgress extends LogsState {}
class LogsWeeklyLoadInProgress extends LogsState {}

class LogsError extends LogsState {
  final String message;

  LogsError({required this.message});
}

// class LogsLoadSuccess extends LogsState {
//   final List<LogsRequestModel?> logslist;
//   final bool isDaily ;
//   final bool isWeekly;

//   LogsLoadSuccess({
//     required this.logslist,
//     this.isDaily = false,
//     this.isWeekly = false,
//   });
// }

class LogsLoadSuccess extends LogsState {
  final List<LogsRequestModel?> logslist;
   final List<LogsWeeklyRequestModel?> logsWeeklyList;

  LogsLoadSuccess({
    required this.logslist,required this.logsWeeklyList,
  });
}

// class LogsWeeklyLoadSuccess extends LogsState {
//   final List<LogsWeeklyRequestModel?> logsWeeklylist;

//   LogsWeeklyLoadSuccess({
//     required this.logsWeeklylist,
//   });
// }