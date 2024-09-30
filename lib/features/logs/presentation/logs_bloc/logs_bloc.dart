import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:wellwave_frontend/features/logs/data/models/logs_request_model.dart';
import 'package:wellwave_frontend/features/logs/data/models/logs_request_model_weekly.dart';
import 'package:wellwave_frontend/features/logs/data/repositories/logs_repositories.dart';

part 'logs_event.dart';
part 'logs_state.dart';

class LogsBloc extends Bloc<LogsEvent, LogsState> {
  final LogsRequestRepository _logsRequestRepository;

  LogsBloc(this._logsRequestRepository) : super(LogsInitial()) {
    on<LogsFetched>(_onLogsFetches);
    // on<LogsFetchedWeekly>(_onWeeklyLogsFetches);
    on<SubmitLogEvent>((event, emit) async {
      await submitLog(event.logName, event.value, event.selectedDate,
          _logsRequestRepository);
    });
    // on<LogsFetchedWaistLine>(_onSpecificLogsFetches);
    // on<LogsFetchedWeight>(_onSpecificLogsFetches);
  }

  Future<void> _onLogsFetches(
      LogsFetched event, Emitter<LogsState> emit) async {
    emit(LogsLoadInProgress());

    try {
      final logsList =
          await _logsRequestRepository.getLogsById('1', event.date);
      final logsWeeklyList =
          await _logsRequestRepository.getWeeklyLogs('1', event.date);
      emit(LogsLoadSuccess(logslist: logsList, logsWeeklyList: logsWeeklyList));
    } catch (e) {
      emit(LogsError(message: e.toString()));
    }
  }

  // Future<void> _onWeeklyLogsFetches(
  //     LogsFetchedWeekly event, Emitter<LogsState> emit) async {
  //   emit(LogsWeeklyLoadInProgress());

  //   try {
  //     final logsWeeklyList =
  //         await _logsRequestRepository.getWeeklyLogs('1', event.date);
  //     emit(LogsLoadSuccess(logsWeeklylist: logsWeeklyList));
  //   } catch (e) {
  //     emit(LogsError(message: e.toString()));
  //   }
  // }

  // Refactor to handle both weight and waist logs using the same function
//   Future<void> _onSpecificLogsFetches(
//       LogsEvent event, Emitter<LogsState> emit) async {
//     emit(LogsWeeklyLoadInProgress());
//     try {
//       String logType;
//       DateTime today;

//       if (event is LogsFetchedWeight) {
//         logType = "WEIGHT_LOG";
//         today = event.date;
//         debugPrint('Fetching weight logs for 4 weeks until date: $today');
//       } else if (event is LogsFetchedWaistLine) {
//         logType = "WAIST_LINE_LOG";
//         today = event.date;
//         debugPrint('Fetching waistline logs for 4 weeks until date: $today');
//       } else {
//         throw Exception("Unknown event type");
//       }

//       final logsList = await _logsRequestRepository.getWeeklyLogsToGraph(
//           '1', today, logType);
//       debugPrint('Logs fetched: $logsList');

//       emit(LogsLoadSuccess(logslist: logsList));
//     } catch (e) {
//       emit(LogsError(message: e.toString()));
//       debugPrint('Error fetching logs: $e');
//     }
//   }
// }

Future<void> submitLog(String logName, int value, String selectedDate,
    LogsRequestRepository logsRepository) async {
  try {
    bool success = await logsRepository.createLogsRequest(
      value: value,
      logName: logName,
      uid: 1,
      date: selectedDate,
    );
    if (success) {
      debugPrint('Log submission successful');
    } else {
      debugPrint('Log submission failed');
    }
  } catch (error) {
    debugPrint('Error submitting log: $error');
  }
}
}