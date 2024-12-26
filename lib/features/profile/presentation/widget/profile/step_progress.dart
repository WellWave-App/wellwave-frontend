import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellwave_frontend/features/profile/presentation/widget/profile/progress_chart_card.dart';
import 'package:wellwave_frontend/features/logs/presentation/logs_bloc/logs_bloc.dart';
import 'package:wellwave_frontend/features/logs/presentation/widget/chart.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';

import '../../../../logs/data/models/logs_request_model_step.dart';

class StepProgressChart extends StatelessWidget {
  final String selectedPeriod;
  final Function(String) onPeriodSelected;

  const StepProgressChart(
      {Key? key, required this.selectedPeriod, required this.onPeriodSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogsBloc, LogsState>(
      builder: (context, state) {
        List<dynamic> filteredLogs = [];

        if (state is LogsLoadGraphInProgress) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is LogsLoadGraphSuccess) {
          if (state.logsSteplist.isNotEmpty) {
            filteredLogs =
                filterLogsByPeriod(state.logsSteplist, selectedPeriod);
          }
        }

        return ProgressChartCard(
          title: AppStrings.stepWalkText,
          value: filteredLogs.isNotEmpty
              ? filteredLogs.last.value.toDouble()
              : 0.0,
          unit: AppStrings.stepText,
          chartValues: filteredLogs
              .map((log) => (log as LogsStepRequestModel).value.toDouble())
              .toList(),
          chart: LineChartSample2(
            logType: AppStrings.stepLogText,
            logs: filteredLogs,
          ),
          onPeriodSelected: onPeriodSelected,
          selectedPeriod: selectedPeriod,
        );
      },
    );
  }

  List<dynamic> filterLogsByPeriod(List<dynamic> logs, String period) {
    switch (period) {
      case '7 วัน':
        return logs.length <= 7 ? logs : logs.sublist(logs.length - 7);
      case '14 วัน':
        return logs.length <= 14 ? logs : logs.sublist(logs.length - 14);
      case '1 เดือน':
        return averageLogsByWeek(logs, DateTime.now(), 4);
      case '3 เดือน':
        return averageLogsByWeek(logs, DateTime.now(), 12);
      default:
        return logs;
    }
  }

  List<dynamic> averageLogsByWeek(
      List<dynamic> logs, DateTime selectedDate, int weeks) {
    List<dynamic> weeklyAverages = [];
    DateTime currentStart = startOfWeek(selectedDate);

    for (int i = 0; i < weeks; i++) {
      DateTime currentEnd = endOfWeek(currentStart);

      List<dynamic> weekLogs = logs.where((log) {
        DateTime logDate = log.date;
        return logDate
                .isAfter(currentStart.subtract(const Duration(days: 1))) &&
            logDate.isBefore(currentEnd.add(const Duration(days: 1)));
      }).toList();

      if (weekLogs.isNotEmpty) {
        double average = weekLogs
                .map((log) => log.value.toDouble())
                .reduce((a, b) => a + b) /
            weekLogs.length;

        weeklyAverages.add(LogsStepRequestModel(
          date: currentEnd,
          value: double.parse(average.toStringAsFixed(1)),
        ));
      } else if (weeklyAverages.isNotEmpty) {
        weeklyAverages.add(LogsStepRequestModel(
          date: currentEnd,
          value: weeklyAverages.last.value,
        ));
      }

      currentStart = currentStart.subtract(const Duration(days: 7));
    }

    return weeklyAverages.reversed.toList();
  }

  DateTime startOfWeek(DateTime date) {
    // Monday
    int difference = date.weekday - DateTime.monday;
    return date.subtract(Duration(days: difference));
  }

  DateTime endOfWeek(DateTime date) {
    // Sunday
    int difference = DateTime.sunday - date.weekday;
    return date.add(Duration(days: difference));
  }
}
