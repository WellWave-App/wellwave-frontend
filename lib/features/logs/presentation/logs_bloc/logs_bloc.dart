import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:wellwave_frontend/features/logs/data/models/logs_request_model.dart';
import 'package:wellwave_frontend/features/logs/data/models/logs_request_model_weekly.dart';
import 'package:wellwave_frontend/features/logs/data/models/logs_request_model_weight.dart';
import 'package:wellwave_frontend/features/logs/data/repositories/logs_repositories.dart';

part 'logs_event.dart';
part 'logs_state.dart';

class LogsBloc extends Bloc<LogsEvent, LogsState> {
  final LogsRequestRepository _logsRequestRepository;

  LogsBloc(this._logsRequestRepository) : super(LogsInitial()) {
    on<LogsFetched>(_onLogsFetches);
    on<SubmitLogEvent>((event, emit) async {
      await submitLog(event.logName, event.value, event.selectedDate,
          _logsRequestRepository);
    });
    on<LogsFetchedWaistLine>(_onSpecificLogsFetches);
    on<LogsFetchedWeight>(_onSpecificLogsFetches);
  }

  Future<void> _onLogsFetches(
      LogsFetched event, Emitter<LogsState> emit) async {
    emit(LogsLoadInProgress());

    try {
      final logsList =
          await _logsRequestRepository.getLogsById('1', event.date);
      final logsWeeklyList =
          await _logsRequestRepository.getWeeklyLogs('1', event.date);

      emit(LogsLoadSuccess(
        logslist: logsList,
        logsWeeklyList: logsWeeklyList,
      ));
    } catch (e) {
      emit(LogsError(message: e.toString()));
    }
  }

  Future<void> _onSpecificLogsFetches(
    LogsEvent event, Emitter<LogsState> emit) async {
  emit(LogsLoadInProgress()); // Emitting loading state
  try {
    String logType;
    DateTime today;

    // Determine which log type based on the event
    if (event is LogsFetchedWeight) {
      logType = "WEIGHT_LOG";
      today = event.date;
      debugPrint('Fetching weight logs for 4 weeks until date: $today');
    } else if (event is LogsFetchedWaistLine) {
      logType = "WAIST_LINE_LOG";
      today = event.date;
      debugPrint('Fetching waist line logs for 4 weeks until date: $today');
    } else {
      throw Exception("Unknown event type");
    }

    // Fetch the logs from the repository
    final logsGraphList = await _logsRequestRepository.getWeeklyLogsToGraph(
        '1', today, logType);
    
    if (logsGraphList.isEmpty) {
      throw Exception('No logs found for $logType');
    }

    // Debugging logs to check if the data is correct
    debugPrint('Logs fetched: $logsGraphList');

    // Emit the success state with the fetched logs
    emit(LogsLoadGraphSuccess(logsGraphlist: logsGraphList));
    debugPrint('Emitted LogsLoadGraphSuccess state');
  } catch (e) {
    emit(LogsError(message: e.toString()));
    debugPrint('Error fetching logs: $e');
  }
}


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
