import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/logs/presentation/logs_bloc/logs_bloc.dart';
import 'package:wellwave_frontend/features/logs/presentation/widget/daily_logs_card.dart';
import 'package:wellwave_frontend/features/logs/presentation/widget/input_daily_logs.dart';

class DailyLogs extends StatefulWidget {
  const DailyLogs({super.key});

  @override
  State<DailyLogs> createState() => _DailyLogsState();
}

class _DailyLogsState extends State<DailyLogs> {
  int selectedWaterLevel = 0;
  int selectedSleepHours = 0;
  DateTime selectedDate = DateTime.now(); 

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.dailyLogsText,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DailyLogCard(
                title: AppStrings.amoutOfWaterText,
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

                    // Submit the water log to BLoC
                    BlocProvider.of<LogsBloc>(context).add(
                      SubmitLogEvent(
                        logName: 'DRINK_LOG',
                        value: selectedWaterLevel,
                        selectedDate: selectedDate.toIso8601String(),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(width: 20),
              DailyLogCard(
                title: AppStrings.hoursOfSleepText,
                unitLabel: AppStrings.hoursText,
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

                    // Submit the sleep log to BLoC
                    BlocProvider.of<LogsBloc>(context).add(
                      SubmitLogEvent(
                        logName: 'SLEEP_LOG',
                        value: selectedSleepHours,
                        selectedDate: selectedDate.toIso8601String(),
                      ),
                    );
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