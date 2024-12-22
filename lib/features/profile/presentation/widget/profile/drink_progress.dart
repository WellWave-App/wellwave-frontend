import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellwave_frontend/features/profile/presentation/widget/profile/progress_chart_card.dart';
import 'package:wellwave_frontend/features/logs/presentation/logs_bloc/logs_bloc.dart';
import 'package:wellwave_frontend/features/logs/presentation/widget/chart.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';

class DrinkProgressChart extends StatelessWidget {
  const DrinkProgressChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogsBloc, LogsState>(
      builder: (context, state) {
        double drink = 0.0;
        double lastWeekDrink = 0.0;

        if (state is LogsLoadGraphInProgress) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is LogsLoadGraphSuccess) {
          if (state.logsDrinklist.isNotEmpty) {
            drink = state.logsDrinklist.last?.value ?? 0.0;
            lastWeekDrink = state.logsDrinklist.length > 1
                ? state.logsDrinklist[state.logsDrinklist.length - 2]?.value ??
                    0.0
                : 0.0;
          }
        }

        return ProgressChartCard(
          title: AppStrings.amoutOfWaterText,
          value: drink,
          unit: AppStrings.glassesText,
          lastWeekValue: lastWeekDrink,
          chart: const LineChartSample2(
            logType: AppStrings.drinkLogText,
          ),
        );
      },
    );
  }
}
