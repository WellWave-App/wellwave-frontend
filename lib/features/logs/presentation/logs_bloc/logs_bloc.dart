import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:wellwave_frontend/features/logs/data/models/logs_request_model.dart';
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
  }

  Future<void> _onLogsFetches(
      LogsFetched event, Emitter<LogsState> emit) async {
    emit(LogsLoadInProgress());

    try {
      final logsList =
          await _logsRequestRepository.getLogsById('1', event.date);

      emit(LogsLoadSuccess(logslist: logsList));
    } catch (e) {
      emit(LogsError(message: e.toString()));
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
