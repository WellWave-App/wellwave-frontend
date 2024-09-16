import 'package:flutter/material.dart';

import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/note/presentation/widget/calendar_slider.dart';

import '../widget/logs_history_card.dart';

class NoteHistoryScreen extends StatefulWidget {
  const NoteHistoryScreen({super.key});

  @override
  State<NoteHistoryScreen> createState() => _NoteHistoryScreenState();
}

class _NoteHistoryScreenState extends State<NoteHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: const TitleSection()),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 16.0,
              child: DecoratedBox(
                decoration: BoxDecoration(color: AppColors.primaryColor),
              ),
            ),
            CalendarSilder(),
            DailyLogs(),
            WeeklyLogs()
          ],
        ),
      ),
    );
  }
}

class TitleSection extends StatelessWidget {
  const TitleSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Text(
      AppStrings.healthHistoryText,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.whiteColor,
          ),
    );
  }
}

//log

class DailyLogs extends StatefulWidget {
  const DailyLogs({super.key});

  @override
  State<DailyLogs> createState() => _DailyLogsState();
}

class _DailyLogsState extends State<DailyLogs> {
  int selectedWaterLevel = 8;
  int selectedSleepHours = 8;

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
          const SizedBox(height: 16),
          Row(
            children: [
              LogsHistoryCard(
                svgPath: AppImages.sleepLogsIcon, // Your SVG asset path
                title: AppStrings.sleepText, // Main text
                value: selectedSleepHours, // Value to display
                isSvg: true,
                unit: AppStrings.hoursText, // Unit for the value
                svgWidth: 64, // Custom width
                svgHeight: 64, // Custom height
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              LogsHistoryCard(
                svgPath: AppImages.threeWaterIcon, // Your SVG asset path
                title: AppStrings.drinkText, // Main text
                value: selectedWaterLevel, // Value to display
                unit: AppStrings.glassesText, // Unit for the value
                isSvg: true,
                svgWidth: 64, // Custom width
                svgHeight: 64, // Custom height
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
  int stepCount = 1002;
  int hdlCount = 65;
  int ldlCount = 165;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 36.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.weeklyLogsText,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.blackColor, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(
            children: [
              LogsHistoryCard(
                pngPath: AppImages.stepCountImage, // Your SVG asset path
                title: AppStrings.stepWalkText, // Main text
                value: stepCount, // Value to display
                unit: AppStrings.stepText, // Unit for the value
                isSvg: false,
                pngWidth: 64, // Custom width
                pngHeight: 64, // Custom height
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              LogsHistoryCard(
                pngPath: AppImages.hdlImage, // Your SVG asset path
                title: AppStrings.hdlText, // Main text
                value: hdlCount, // Value to display
                unit: AppStrings.mgPerDlText, // Unit for the value
                isSvg: false,
                pngWidth: 64, // Custom width
                pngHeight: 64, // Custom height
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              LogsHistoryCard(
                pngPath: AppImages.ldlImage, // Your SVG asset path
                title: AppStrings.ldlText, // Main text
                value: ldlCount, // Value to display
                unit: AppStrings.mgPerDlText, // Unit for the value
                isSvg: false,
                pngWidth: 64, // Custom width
                pngHeight: 64, // Custom height
              ),
            ],
          ),
        ],
      ),
    );
  }
}
