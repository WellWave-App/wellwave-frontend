import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:wellwave_frontend/features/logs/data/models/logs_request_model.dart';
import 'package:wellwave_frontend/features/logs/data/models/logs_request_model_waistline.dart';
import 'package:wellwave_frontend/features/logs/data/models/logs_request_model_weekly.dart';
import 'package:wellwave_frontend/features/logs/data/models/logs_request_model_weight.dart';
import 'package:wellwave_frontend/features/logs/data/repositories/logs_repositories.dart';
import 'package:intl/intl.dart';

import '../../../../config/constants/app_strings.dart';
import '../../data/models/logs_request_model_sleep.dart';
import '../../data/models/logs_request_model_drink.dart';
import '../../data/models/logs_request_model_step.dart';

part 'logs_event.dart';
part 'logs_state.dart';

class LogsBloc extends Bloc<LogsEvent, LogsState> {
  final LogsRequestRepository _logsRequestRepository;

  LogsBloc(this._logsRequestRepository) : super(LogsInitial()) {
    on<LogsFetched>(_onLogsFetches);
    on<LogsFetchedGraph>(_onGraphLogsFetches);
    on<SubmitLogEvent>((event, emit) async {
      await submitLog(event.logName, event.value, event.selectedDate,
          _logsRequestRepository);
    });
  }

  int uid = AppStrings.uid;

  Future<void> _onLogsFetches(
      LogsFetched event, Emitter<LogsState> emit) async {
    emit(LogsLoadInProgress());

    try {
      final logsList =
          await _logsRequestRepository.getLogsById(uid, event.date);
      final logsWeeklyList =
          await _logsRequestRepository.getWeeklyLogs(uid, event.date);
      final logsLastWeekList = await _logsRequestRepository.getWeeklyLogs(
          uid, event.date.subtract(const Duration(days: 7)));

      emit(LogsLoadSuccess(
        logslist: logsList,
        logsWeeklyList: logsWeeklyList,
        logsLastWeekList: logsLastWeekList,
      ));
    } catch (e) {
      emit(LogsError(message: e.toString()));
    }
  }

  Future<void> _onGraphLogsFetches(
      LogsFetchedGraph event, Emitter<LogsState> emit) async {
    emit(LogsLoadGraphInProgress());

    try {
      final logsWeightList =
          await _logsRequestRepository.getWeightLogs(uid, event.date);
      final logsWaistLineList =
          await _logsRequestRepository.getWaistLineLogs(uid, event.date);
      final logsDrinkList =
          await _logsRequestRepository.getDrinkLogs(uid, event.date);
      final logsStepList =
          await _logsRequestRepository.getStepLogs(uid, event.date);
      final logsSleepList =
          await _logsRequestRepository.getSleepLogs(uid, event.date);

      emit(LogsLoadGraphSuccess(
        logsDrinklist: logsDrinkList,
        logsSleeplist: logsSleepList,
        logsSteplist: logsStepList,
        logsWeightlist: logsWeightList,
        logsWaistLinelist: logsWaistLineList,
      ));
    } catch (e) {
      emit(LogsError(message: e.toString()));
    }
  }

  Future<void> submitLog(String logName, int value, String selectedDate,
      LogsRequestRepository logsRepository) async {
    try {
      // Format the date as YYYY-MM-DD
      String formattedDate =
          DateFormat('yyyy-MM-dd').format(DateTime.parse(selectedDate));

      bool logExists = await logsRepository.logExists(
        logName: logName,
        uid: uid,
        date: formattedDate,
      );

      bool success;
      if (logExists) {
        success = await logsRepository.editLogsRequest(
          value: value,
          logName: logName,
          uid: uid,
          date: formattedDate,
        );
      } else {
        success = await logsRepository.createLogsRequest(
          value: value,
          logName: logName,
          uid: uid,
          date: formattedDate,
        );
      }

      if (success) {
        debugPrint('Log operation successful');
      } else {
        debugPrint('Log operation failed');
      }
    } catch (error) {
      debugPrint('Error submitting log: $error');
    }
  }
}
