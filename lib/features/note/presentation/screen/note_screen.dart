import 'package:flutter/material.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/note/presentation/widget/chart.dart';
import 'package:wellwave_frontend/features/note/presentation/widget/daily_logs_card.dart';
import 'package:wellwave_frontend/features/note/presentation/widget/input_button.dart';
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
                unitLabel: AppStrings.glassesText,
                selectedLevel: selectedWaterLevel,
                maxLevel: 11,
                svgIcons: const [
                  AppImages.water0Icon,
                  AppImages.water1Icon,
                  AppImages.water2Icon,
                  AppImages.water3Icon,
                  AppImages.water4Icon,
                  AppImages.water5Icon,
                  AppImages.water6Icon,
                  AppImages.water7Icon,
                  AppImages.water8Icon,
                  AppImages.water9Icon,
                  AppImages.water10Icon,
                ],
                onTap: () async {
                  int? result = await showDialog<int>(
                      context: context,
                      builder: (context) => InputDailyLogs(
                            initialUnits: selectedWaterLevel,
                            title: AppStrings.amoutOfWaterText,
                            unitLabel: AppStrings.glassesText,
                            maxLevel: 11,
                            svgIcons: const [
                              AppImages.water0Icon,
                              AppImages.water1Icon,
                              AppImages.water2Icon,
                              AppImages.water3Icon,
                              AppImages.water4Icon,
                              AppImages.water5Icon,
                              AppImages.water6Icon,
                              AppImages.water7Icon,
                              AppImages.water8Icon,
                              AppImages.water9Icon,
                              AppImages.water10Icon,
                            ],
                          ));
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
                maxLevel: 11,
                svgIcons: const [
                  AppImages.moon0Icon,
                  AppImages.moon1Icon,
                  AppImages.moon2Icon,
                  AppImages.moon3Icon,
                  AppImages.moon4Icon,
                  AppImages.moon5Icon,
                  AppImages.moon6Icon,
                  AppImages.moon7Icon,
                  AppImages.moon8Icon,
                  AppImages.moon9Icon,
                  AppImages.moon10Icon,
                ],
                onTap: () async {
                  int? result = await showDialog<int>(
                      context: context,
                      builder: (context) => InputDailyLogs(
                            title: AppStrings.hoursOfSleepText,
                            initialUnits: selectedSleepHours,
                            unitLabel: AppStrings.hoursText,
                            maxLevel: 11,
                            svgIcons: const [
                              AppImages.moon0Icon,
                              AppImages.moon1Icon,
                              AppImages.moon2Icon,
                              AppImages.moon3Icon,
                              AppImages.moon4Icon,
                              AppImages.moon5Icon,
                              AppImages.moon6Icon,
                              AppImages.moon7Icon,
                              AppImages.moon8Icon,
                              AppImages.moon9Icon,
                              AppImages.moon10Icon,
                            ],
                          ));
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
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.bold)),
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
