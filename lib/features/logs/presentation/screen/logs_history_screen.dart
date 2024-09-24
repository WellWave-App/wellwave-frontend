import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/logs/presentation/logs_bloc/logs_bloc.dart';
import 'package:wellwave_frontend/features/logs/presentation/widget/calendar_slider.dart';
import '../widget/logs_history_card.dart';

class LogsHistoryScreen extends StatefulWidget {
  const LogsHistoryScreen({super.key});

  @override
  _LogsHistoryScreenState createState() => _LogsHistoryScreenState();
}

class _LogsHistoryScreenState extends State<LogsHistoryScreen> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: Text(
      AppStrings.healthHistoryText,
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.bold,
          ),
    )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              width: double.infinity,
              height: 16.0,
              child: DecoratedBox(
                decoration: BoxDecoration(color: AppColors.primaryColor),
              ),
            ),
            CalendarSilder(
              onDateSelected: (date) {
                setState(() {
                  _selectedDate = date; // Update the selected date
                });
                context.read<LogsBloc>().add(LogsFetched(
                    date: _selectedDate)); // Refetch logs with new date
              },
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.dailyLogsText,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),

                  BlocBuilder<LogsBloc, LogsState>(
                    builder: (context, state) {
                      if (state is LogsLoadInProgress) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is LogsLoadSuccess) {
                        double? selectedSleepHours;
                        double? selectedDrinkLogs;

                        for (var log in state.logslist) {
                          if (log?.logName == 'SLEEP_LOG') {
                            selectedSleepHours = log?.value;
                          } else if (log?.logName == 'DRINK_LOG') {
                            selectedDrinkLogs = log?.value;
                          }
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (selectedSleepHours != null)
                              Row(
                                children: [
                                  LogsHistoryCard(
                                    svgPath: AppImages.sleepLogsIcon,
                                    title: AppStrings.sleepText,
                                    value: selectedSleepHours,
                                    isSvg: true,
                                    unit: AppStrings.hoursText,
                                    svgWidth: 64,
                                    svgHeight: 64,
                                  ),
                                ],
                              ),
                            const SizedBox(height: 8.0),
                            if (selectedDrinkLogs != null)
                              Row(
                                children: [
                                  LogsHistoryCard(
                                    svgPath: AppImages.threeWaterIcon,
                                    title: AppStrings.drinkText,
                                    value: selectedDrinkLogs,
                                    unit: AppStrings.glassesText,
                                    isSvg: true,
                                    svgWidth: 64,
                                    svgHeight: 64,
                                  ),
                                ],
                              ),
                            if (selectedSleepHours == null &&
                                selectedDrinkLogs == null)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'ไม่มีข้อมูลสำหรับวันนี้',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: AppColors.darkGrayColor,
                                        ),
                                  )
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
            ),
            const WeeklyLogs(),
          ],
        ),
      ),
    );
  }
}

class WeeklyLogs extends StatelessWidget {
  const WeeklyLogs({super.key});

  @override
  Widget build(BuildContext context) {
    double stepCount = 1002;
    double hdlCount = 65;
    double ldlCount = 165;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 36.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.weeklyLogsText,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(
            children: [
              LogsHistoryCard(
                pngPath: AppImages.stepCountImage,
                title: AppStrings.stepWalkText,
                value: stepCount,
                unit: AppStrings.stepText,
                isSvg: false,
                pngWidth: 64,
                pngHeight: 64,
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              LogsHistoryCard(
                pngPath: AppImages.hdlImage,
                title: AppStrings.hdlText,
                value: hdlCount,
                unit: AppStrings.mgPerDlText,
                isSvg: false,
                pngWidth: 64,
                pngHeight: 64,
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              LogsHistoryCard(
                pngPath: AppImages.ldlImage,
                title: AppStrings.ldlText,
                value: ldlCount,
                unit: AppStrings.mgPerDlText,
                isSvg: false,
                pngWidth: 64,
                pngHeight: 64,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
