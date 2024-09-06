import 'package:flutter/material.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/note/presentation/widget/chart.dart';
import 'package:wellwave_frontend/features/note/presentation/widget/daily_logs_card.dart';
import 'package:wellwave_frontend/features/note/presentation/widget/input_daily_logs.dart';
import 'package:wellwave_frontend/features/note/presentation/widget/weekly_logs_card.dart';
import 'note_history_screen.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const TitleSection()),
      body: const SingleChildScrollView(
        child: Column(
          children: [DailyLogs(), WeeklyLogs()],
        ),
      ),
    );
  }
}

class TitleSection extends StatelessWidget {
  const TitleSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all<Color>(Colors.grey),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const NoteHistoryScreen()),
            );
          },
          child: Text(
            AppStrings.historyText,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColors.greyColor,
                  // fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ],
    );
  }
}

class DailyLogs extends StatefulWidget {
  const DailyLogs({super.key});

  @override
  State<DailyLogs> createState() => _DailyLogsState();
}

class _DailyLogsState extends State<DailyLogs> {
  int selectedWaterLevel = 0;
  int selectedSleepHours = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.dailyLogsText,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.blackColor, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DailyLogCard(
                title: AppStrings.amoutOfWaterText, // Water intake
                unitLabel: AppStrings.glassesText, // Glasses
                selectedLevel: selectedWaterLevel,
                maxLevel: 8,
                icon: Icons.water_drop_rounded,
                iconColor: Colors.blue,
                onTap: () async {
                  int? result = await showDialog<int>(
                    context: context,
                    builder: (context) => InputDailyLogs(
                      initialUnits: selectedWaterLevel,
                      inputIcon: Icons.water_drop_rounded,
                    ),
                  );
                  if (result != null) {
                    setState(() {
                      selectedWaterLevel = result;
                    });
                  }
                },
              ),
              const SizedBox(width: 20),
              DailyLogCard(
                title: AppStrings.hoursOfSleepText, // Sleep tracking
                unitLabel: AppStrings.hoursText, // Hours
                selectedLevel: selectedSleepHours,
                maxLevel: 12,
                icon: Icons.nights_stay,
                iconColor: Colors.yellow,
                onTap: () async {
                  int? result = await showDialog<int>(
                    context: context,
                    builder: (context) => InputDailyLogs(
                      initialUnits: selectedSleepHours,
                      inputIcon: Icons.nights_stay,
                      inputColor: Colors.yellow,
                      maxLevel: 12,
                    ),
                  );
                  if (result != null) {
                    setState(() {
                      selectedSleepHours = result;
                    });
                  }
                },
              ),
            ],
          ),
        ],
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
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
  children: [
    WeeklyLogsCard(
      title: AppStrings.weightText,
      value: '50',
      unit: AppStrings.kgText,
      chart: LineChartSample2(), // Replace with actual chart widget
    ),
  ],
),
SizedBox(height: 16),
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    WeeklyLogsCard(
      title: AppStrings.hdlText,
      value: '65',
      unit: AppStrings.mgPerDlText,
      chart: LineChartSample2(), // Replace with actual chart widget
    ),
    SizedBox(width: 16),
    WeeklyLogsCard(
      title: AppStrings.ldlText,
      value: '165',
      unit: AppStrings.mgPerDlText,
      chart: LineChartSample2(), // Replace with actual chart widget
    ),
  ],
),
        ],
      ),
    );
  }
}
