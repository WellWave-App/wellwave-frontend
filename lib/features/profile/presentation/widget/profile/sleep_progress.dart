import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellwave_frontend/features/profile/presentation/widget/profile/progress_chart_card.dart';
import 'package:wellwave_frontend/features/logs/presentation/logs_bloc/logs_bloc.dart';
import 'package:wellwave_frontend/features/logs/presentation/widget/chart.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';

class SleepProgressChart extends StatelessWidget {
  const SleepProgressChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogsBloc, LogsState>(
      builder: (context, state) {
        double sleep = 0.0;
        double lastWeekSleep = 0.0;

        if (state is LogsLoadGraphInProgress) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is LogsLoadGraphSuccess) {
          if (state.logsSleeplist.isNotEmpty) {
            sleep = state.logsSleeplist.last?.value ?? 0.0;
            lastWeekSleep = state.logsSleeplist.length > 1
                ? state.logsSleeplist[state.logsSleeplist.length - 2]?.value ??
                    0.0
                : 0.0;
          }
        }

        return ProgressChartCard(
          title: AppStrings.sleepText,
          value: sleep,
          unit: AppStrings.hoursText,
          lastWeekValue: lastWeekSleep,
          chart: const LineChartSample2(
            logType: AppStrings.sleepLogText,
          ),
        );
      },
    );
  }
}
