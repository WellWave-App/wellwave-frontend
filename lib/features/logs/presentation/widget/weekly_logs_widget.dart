import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/logs/presentation/logs_bloc/logs_bloc.dart';
import 'package:wellwave_frontend/features/logs/presentation/widget/logs_history_card.dart';

class WeeklyLogsWidget extends StatelessWidget {
  final DateTime selectedDate;

  const WeeklyLogsWidget({
    Key? key,
    required this.selectedDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<LogsBloc>().add(LogsFetched(selectedDate));

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 36.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            AppStrings.weeklyLogsText,
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          BlocBuilder<LogsBloc, LogsState>(builder: (context, state) {
            if (state is LogsLoadInProgress) {
                                        debugPrint('weekly log widget');

              return const Center(child: CircularProgressIndicator());
            } else if (state is LogsLoadSuccess) {
              double? stepCount;
              double? weightCount;
              double? waistLineCount;
              double? hdlCount;
              double? ldlCount;

              for (var log in state.logsWeeklyList) {
                if (log?.logName == 'STEP_LOG') {
                  stepCount = log?.value;
                } else if (log?.logName == 'WEIGHT_LOG') {
                  weightCount = log?.value;
                }else if (log?.logName == 'WAIST_LINE_LOG') {
                  waistLineCount = log?.value;
                }else if (log?.logName == 'HDL_LOG') {
                  hdlCount = log?.value;
                } else if (log?.logName == 'LDL_LOG') {
                  ldlCount = log?.value;
                }
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (stepCount != null)
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
                  if (weightCount != null)
                    Row(
                      children: [
                        LogsHistoryCard(
                          pngPath: AppImages.hdlImage,
                          title: AppStrings.weightText,
                          value: weightCount,
                          unit: AppStrings.kgText,
                          isSvg: false,
                          pngWidth: 64,
                          pngHeight: 64,
                        ),
                      ],
                    ),
                  const SizedBox(height: 8.0),
                  if (waistLineCount != null)
                    Row(
                      children: [
                        LogsHistoryCard(
                          pngPath: AppImages.hdlImage,
                          title: AppStrings.waistLineText,
                          value: waistLineCount,
                          unit: AppStrings.cmText,
                          isSvg: false,
                          pngWidth: 64,
                          pngHeight: 64,
                        ),
                      ],
                    ),
                  const SizedBox(height: 8.0),
                  if (hdlCount != null)
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
                  if (ldlCount != null)
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
                  const SizedBox(height: 8.0),
                  if (stepCount == null && weightCount == null&& waistLineCount == null&& hdlCount == null && ldlCount == null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'ไม่มีข้อมูลสำหรับสัปดาห์นี้',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: AppColors.darkGrayColor),
                        ),
                      ],
                    ),
                ],
              );
            } else if (state is LogsError) {
              return const Center(child: Text('Error loading weekly logs.'));
            }

            return const Center(child: Text('No weekly logs available.'));
          })
        ]));
  }
}
