import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/logs/presentation/logs_bloc/logs_bloc.dart';
import 'package:wellwave_frontend/features/logs/presentation/widget/logs_history_card.dart';

class DailyLogsWidget extends StatelessWidget {
  const DailyLogsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            );
  }
}