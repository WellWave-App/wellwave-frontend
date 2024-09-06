import 'dart:math';
import 'package:flutter/material.dart';
import 'package:calendar_slider/calendar_slider.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';

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
            // fontWeight: FontWeight.bold,
          ),
    );
  }
}

// CalendarSilder widget
class CalendarSilder extends StatefulWidget {
  const CalendarSilder({Key? key}) : super(key: key);

  @override
  State<CalendarSilder> createState() => _CalendarSilderState();
}

class _CalendarSilderState extends State<CalendarSilder> {
  final CalendarSliderController _firstController = CalendarSliderController();

  Random random = Random();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CalendarSlider(
          controller: _firstController,
          selectedDayPosition: SelectedDayPosition.center,
          fullCalendarScroll: FullCalendarScroll.horizontal,
          backgroundColor: AppColors.primaryColor,
          fullCalendarWeekDay: WeekDay.short,
          selectedTileBackgroundColor: AppColors.mintColor,
          monthYearButtonBackgroundColor: Colors.transparent,
          monthYearTextColor: Colors.white,
          tileBackgroundColor: AppColors.primaryColor,
          selectedDateColor: Colors.white,
          dateColor: Colors.white,
          tileShadow: BoxShadow(
            color: Colors.black.withOpacity(1),
          ),
          locale: 'th',
          initialDate: DateTime.now(),
          firstDate: DateTime.now().subtract(const Duration(days: 100)),
          lastDate: DateTime.now().add(const Duration(days: 100)),
          onDateSelected: (date) {
            setState(() {});
          },
        ),
      ],
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
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: AppColors.tertiaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(AppImages.sleepLogsIcon,
                          width: 64, // Set the width
                          height: 64),
                      const SizedBox(width: 8.0),
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                AppStrings.sleepText,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                      color: AppColors.greyColor,
                                    ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                '$selectedWaterLevel ${AppStrings.hoursText}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                        color: AppColors.blackColor,
                                        fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: AppColors.tertiaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(AppImages.threeWaterIcon,
                          width: 64, // Set the width
                          height: 64),
                      const SizedBox(width: 8.0),
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                AppStrings.drinkText,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                      color: AppColors.greyColor,
                                    ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                '$selectedWaterLevel ${AppStrings.glassesText}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                        color: AppColors.blackColor,
                                        fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
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
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: AppColors.tertiaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Image.asset(AppImages.stepCountImage,
                          width: 64,
                          height: 64),
                      const SizedBox(width: 8.0),
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                AppStrings.stepWalkText,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                      color: AppColors.greyColor,
                                    ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                '$stepCount ${AppStrings.stepText}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                        color: AppColors.blackColor,
                                        fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: AppColors.tertiaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Image.asset(AppImages.hdlImage,
                          width: 64, 
                          height: 64),
                      const SizedBox(width: 8.0),
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                AppStrings.hdlText,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                      color: AppColors.greyColor,
                                    ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                '$hdlCount ${AppStrings.mgPerDlText}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                        color: AppColors.blackColor,
                                        fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: AppColors.tertiaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Image.asset(AppImages.ldlImage,
                          width: 64, 
                          height: 64),
                      const SizedBox(width: 8.0),
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                AppStrings.ldlText,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                      color: AppColors.greyColor,
                                    ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                '$ldlCount ${AppStrings.mgPerDlText}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                        color: AppColors.blackColor,
                                        fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
