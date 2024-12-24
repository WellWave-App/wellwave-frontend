import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellwave_frontend/features/profile/presentation/widget/profile/progress_chart_card.dart';
import 'package:wellwave_frontend/features/logs/presentation/logs_bloc/logs_bloc.dart';
import 'package:wellwave_frontend/features/logs/presentation/widget/chart.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';

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
        // double step = 0.0;
        // double lastWeekStep = 0.0;

        if (state is LogsLoadGraphInProgress) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is LogsLoadGraphSuccess) {
          if (state.logsSteplist.isNotEmpty) {
            filteredLogs =
                filterLogsByPeriod(state.logsSteplist, selectedPeriod);
            // step = state.logsSteplist.last?.value ?? 0.0;
            // lastWeekStep = state.logsSteplist.length > 1
            //     ? state.logsSteplist[state.logsSteplist.length - 2]?.value ??
            //         0.0
            //     : 0.0;
          }
        }

        return ProgressChartCard(
          title: AppStrings.stepWalkText,
          value: filteredLogs.isNotEmpty
              ? filteredLogs.last.value.toDouble()
              : 0.0,
          unit: AppStrings.stepText,
          lastWeekValue: filteredLogs.length > 1
              ? filteredLogs[filteredLogs.length - 2].value.toDouble()
              : 0.0,
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
