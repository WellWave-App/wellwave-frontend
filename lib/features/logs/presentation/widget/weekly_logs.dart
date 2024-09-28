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
          BlocBuilder<LogsBloc, LogsState>(
            builder: (context, state) {
              bool logsRecorded = false;
              if (state is LogsLoadSuccess) {
                for (var log in state.logslist) {
                  if (log?.logName == 'WEIGHT_LOG' && log?.value != null) {
                    logsRecorded = true;
                  }
                }
              }

              return Row(
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
                  logsRecorded
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[400], // Gray background
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Text(
                              AppStrings
                                  .dataRecordingCompletedText, // Already recorded text
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(color: Colors.white)),
                        )
                      : const InputButton(
                          buttonText: AppStrings.dataRecordingText,
                        ),
                ],
              );
            },
          ),
          const SizedBox(height: 16),
          BlocBuilder<LogsBloc, LogsState>(
            builder: (context, state) {
              if (state is LogsLoadInProgress) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is LogsLoadSuccess) {
                double weight = 0.0;
                double waistLine = 0.0;

                for (var log in state.logslist) {
                  if (log?.logName == 'WEIGHT_LOG') {
                    weight = log?.value ?? 0.0;
                  } else if (log?.logName == 'WAIST_LINE_LOG') {
                    waistLine = log?.value ?? 0.0;
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
                      children: [
                        WeeklyLogsCard(
                          title: AppStrings.waistLineText,
                          value: waistLine,
                          unit: AppStrings.cmText,
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
