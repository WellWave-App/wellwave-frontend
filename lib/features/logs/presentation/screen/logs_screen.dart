import 'package:flutter/material.dart';
import 'package:wellwave_frontend/features/logs/presentation/widget/daily_logs.dart';
import 'package:wellwave_frontend/features/logs/presentation/widget/history_button.dart';
import 'package:wellwave_frontend/features/logs/presentation/widget/weekly_logs.dart';

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

