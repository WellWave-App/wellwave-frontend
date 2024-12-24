import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellwave_frontend/features/profile/presentation/widget/profile/progress_chart_card.dart';
import 'package:wellwave_frontend/features/logs/presentation/logs_bloc/logs_bloc.dart';
import 'package:wellwave_frontend/features/logs/presentation/widget/chart.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';

class SleepProgressChart extends StatelessWidget {
  final String selectedPeriod;
  final Function(String) onPeriodSelected;

  const SleepProgressChart(
      {Key? key, required this.selectedPeriod, required this.onPeriodSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogsBloc, LogsState>(
      builder: (context, state) {
        List<dynamic> filteredLogs = [];
        // double sleep = 0.0;
        // double lastWeekSleep = 0.0;

        if (state is LogsLoadGraphInProgress) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is LogsLoadGraphSuccess) {
          if (state.logsSleeplist.isNotEmpty) {
            filteredLogs =
                filterLogsByPeriod(state.logsSleeplist, selectedPeriod);
            // sleep = state.logsSleeplist.last?.value ?? 0.0;
            // lastWeekSleep = state.logsSleeplist.length > 1
            //     ? state.logsSleeplist[state.logsSleeplist.length - 2]?.value ??
            //         0.0
            //     : 0.0;
          }
        }

        return ProgressChartCard(
          title: AppStrings.sleepText,
          value: filteredLogs.isNotEmpty
              ? filteredLogs.last.value.toDouble()
              : 0.0,
          unit: AppStrings.hoursText,
          lastWeekValue: filteredLogs.length > 1
              ? filteredLogs[filteredLogs.length - 2].value.toDouble()
              : 0.0,
          chart: LineChartSample2(
            logType: AppStrings.drinkLogText,
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
        return logs.take(7).toList();
      case '14 วัน':
        return logs.take(14).toList();
      // case '1 เดือน':
      //   return averageLogsByWeek(logs, 4);
      // case '3 เดือน':
      //   return averageLogsByWeek(logs, 12);
      // case '6 เดือน':
      //   return averageLogsByMonth(logs, 6);
      default:
        return logs;
    }
  }

  // List<dynamic> averageLogsByWeek(List<dynamic> logs, int weeks) {
  //   // Implement logic to calculate weekly averages for the last `weeks` weeks
  // }

  // List<dynamic> averageLogsByMonth(List<dynamic> logs, int months) {
  //   // Implement logic to calculate monthly averages for the last `months` months
  // }
}
