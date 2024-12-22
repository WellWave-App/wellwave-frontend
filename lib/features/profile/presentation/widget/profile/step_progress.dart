import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellwave_frontend/features/profile/presentation/widget/profile/progress_chart_card.dart';
import 'package:wellwave_frontend/features/logs/presentation/logs_bloc/logs_bloc.dart';
import 'package:wellwave_frontend/features/logs/presentation/widget/chart.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';

class StepProgressChart extends StatelessWidget {
  const StepProgressChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogsBloc, LogsState>(
      builder: (context, state) {
        double step = 0.0;
        double lastWeekStep = 0.0;

        if (state is LogsLoadGraphInProgress) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is LogsLoadGraphSuccess) {
          if (state.logsSteplist.isNotEmpty) {
            step = state.logsSteplist.last?.value ?? 0.0;
            lastWeekStep = state.logsSteplist.length > 1
                ? state.logsSteplist[state.logsSteplist.length - 2]?.value ??
                    0.0
                : 0.0;
          }
        }

        return ProgressChartCard(
          title: AppStrings.stepWalkText,
          value: step,
          unit: AppStrings.stepText,
          lastWeekValue: lastWeekStep,
          chart: const LineChartSample2(
            logType: AppStrings.stepLogText,
          ),
        );
      },
    );
  }
}
