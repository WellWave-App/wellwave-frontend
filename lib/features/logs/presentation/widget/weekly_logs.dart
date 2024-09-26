import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/logs/presentation/logs_bloc/logs_bloc.dart';
import 'package:wellwave_frontend/features/logs/presentation/widget/chart.dart';
import 'package:wellwave_frontend/features/logs/presentation/widget/input_button.dart';
import 'package:wellwave_frontend/features/logs/presentation/widget/weekly_logs_card.dart';

class WeeklyLogs extends StatefulWidget {
  const WeeklyLogs({super.key});

  @override
  State<WeeklyLogs> createState() => _WeeklyLogsState();
}

class _WeeklyLogsState extends State<WeeklyLogs> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(AppStrings.weeklyLogsText,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
              const Column(
                children: [
                  InputButton(
                    buttonText: AppStrings.dataRecordingText,
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 16),
          BlocBuilder<LogsBloc, LogsState>(
            builder: (context, state) {
              if (state is LogsLoadInProgress) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is LogsLoadSuccess) {
                double weight = 0.0;
                double hdl = 0.0;
                double ldl = 0.0;

                for (var log in state.logslist) {
                  if (log?.logName == 'WEIGHT_LOG') {
                    weight = log?.value ?? 0.0;
                  } else if (log?.logName == 'HDL_LOG') {
                    hdl = log?.value ?? 0.0;
                  } else if (log?.logName == 'LDL_LOG') {
                    ldl = log?.value ?? 0.0;
                  }
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        WeeklyLogsCard(
                          title: AppStrings.weightText,
                          value: weight,
                          unit: AppStrings.kgText,
                          chart: const LineChartSample2(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        WeeklyLogsCard(
                          title: AppStrings.hdlText,
                          value: hdl,
                          unit: AppStrings.mgPerDlText,
                          chart: const LineChartSample2(),
                        ),
                        const SizedBox(width: 16),
                        WeeklyLogsCard(
                          title: AppStrings.ldlText,
                          value: ldl,
                          unit: AppStrings.mgPerDlText,
                          chart: const LineChartSample2(),
                        ),
                      ],
                    ),
                  ],
                );
              } else if (state is LogsError) {
                return const Center(child: Text('Error loading logs.'));
              }
              return const Center(child: Text('No logs available.'));
            },
          ),
        ],
      ),
    );
  }
}
