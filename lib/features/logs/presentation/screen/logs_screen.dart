import 'package:flutter/material.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/logs/presentation/widget/chart.dart';
import 'package:wellwave_frontend/features/logs/presentation/widget/daily_logs.dart';
import 'package:wellwave_frontend/features/logs/presentation/widget/history_button.dart';
import 'package:wellwave_frontend/features/logs/presentation/widget/input_button.dart';
import 'package:wellwave_frontend/features/logs/presentation/widget/weekly_logs_card.dart';

class LogsScreen extends StatefulWidget {
  const LogsScreen({super.key});

  @override
  State<LogsScreen> createState() => _LogsScreenState();
}

class _LogsScreenState extends State<LogsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        HistoryButton()
      ],
    )),
      body: const SingleChildScrollView(
        child: Column(
          children: [DailyLogs(), WeeklyLogs()],
        ),
      ),
    );
  }
}

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
          const Row(
            children: [
              WeeklyLogsCard(
                title: AppStrings.weightText,
                value: '50',
                unit: AppStrings.kgText,
                chart: LineChartSample2(), // Replace with actual chart widget
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              WeeklyLogsCard(
                title: AppStrings.hdlText,
                value: '65',
                unit: AppStrings.mgPerDlText,
                chart: LineChartSample2(),
              ),
              SizedBox(width: 16),
              WeeklyLogsCard(
                title: AppStrings.ldlText,
                value: '165',
                unit: AppStrings.mgPerDlText,
                chart: LineChartSample2(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
