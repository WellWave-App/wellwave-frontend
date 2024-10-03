import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/logs/data/models/logs_request_model_weekly.dart';
import 'package:wellwave_frontend/features/logs/presentation/logs_bloc/logs_bloc.dart';
import 'package:wellwave_frontend/features/logs/presentation/widget/logs_history_card.dart';

class WeeklyLogsWidget extends StatelessWidget {
  final DateTime selectedDate;

  const WeeklyLogsWidget({Key? key, required this.selectedDate})
      : super(key: key);

  //start of the week (Monday)
  DateTime startOfWeek(DateTime date) {
    int difference = date.weekday - DateTime.monday;
    return date.subtract(Duration(days: difference));
  }

  //end of the week (Sunday)
  DateTime endOfWeek(DateTime date) {
    int difference = DateTime.sunday - date.weekday;
    return date.add(Duration(days: difference));
  }

  String formatDateThai(DateTime date) {
    final thaiMonths = [
      'มกราคม',
      'กุมภาพันธ์',
      'มีนาคม',
      'เมษายน',
      'พฤษภาคม',
      'มิถุนายน',
      'กรกฎาคม',
      'สิงหาคม',
      'กันยายน',
      'ตุลาคม',
      'พฤศจิกายน',
      'ธันวาคม'
    ];
    return '${date.day} ${thaiMonths[date.month - 1]} ${date.year + 543}';
  }

  @override
  Widget build(BuildContext context) {
    final start = startOfWeek(selectedDate);
    final end = endOfWeek(selectedDate);

    String formattedStart = formatDateThai(start);
    String formattedEnd = formatDateThai(end);

    context.read<LogsBloc>().add(LogsFetched(selectedDate));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 36.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.weeklyLogsText,
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text(
            '$AppStrings.xdate $formattedStart - $formattedEnd',
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: AppColors.darkGrayColor),
          ),
          const SizedBox(height: 16),
          BlocBuilder<LogsBloc, LogsState>(
            builder: (context, state) {
              if (state is LogsLoadInProgress) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is LogsLoadSuccess) {
                final currentWeekLogs = state.logsWeeklyList;
                final lastWeekLogs = state.logsLastWeekList;

                double? stepCount =
                    getLogValue(currentWeekLogs, AppStrings.stepLogText);
                double? weightCount =
                    getLogValue(currentWeekLogs, AppStrings.weightLogText);
                double? waistLineCount =
                    getLogValue(currentWeekLogs, AppStrings.waistLineLogText);
                double? hdlCount =
                    getLogValue(currentWeekLogs, AppStrings.hdlLogText);
                double? ldlCount =
                    getLogValue(currentWeekLogs, AppStrings.ldlLogText);

                double lastWeekStep =
                    getLogValue(lastWeekLogs, AppStrings.stepLogText) ?? 0.0;
                double lastWeekWeight =
                    getLogValue(lastWeekLogs, AppStrings.weightLogText) ?? 0.0;
                double lastWeekWaistLine =
                    getLogValue(lastWeekLogs, AppStrings.waistLineLogText) ??
                        0.0;
                double lastWeekHdl =
                    getLogValue(lastWeekLogs, AppStrings.hdlLogText) ?? 0.0;
                double lastWeekLdl =
                    getLogValue(lastWeekLogs, AppStrings.ldlLogText) ?? 0.0;

                return Column(
                  children: [
                    LogsHistoryCard(
                      title: AppStrings.stepWalkText,
                      unit: AppStrings.stepText,
                      svgPath: AppImages.stepCountImage,
                      value: stepCount ?? 0.0,
                      lastWeekValue: lastWeekStep,
                      isSvg: true,
                      isShow: true,
                    ),
                    LogsHistoryCard(
                      title: AppStrings.weightText,
                      unit: AppStrings.kgText,
                      svgPath: AppImages.weightIcon,
                      value: weightCount ?? 0.0,
                      lastWeekValue: lastWeekWeight,
                      isSvg: true,
                      isShow: true,
                    ),
                    LogsHistoryCard(
                      title: AppStrings.waistLineText,
                      unit: AppStrings.cmText,
                      svgPath: AppImages.waistLineIcon,
                      value: waistLineCount ?? 0.0,
                      lastWeekValue: lastWeekWaistLine,
                      isSvg: true,
                      isShow: true,
                    ),
                    LogsHistoryCard(
                      title: AppStrings.hdlText,
                      unit: AppStrings.mgPerDlText,
                      pngPath: AppImages.hdlImage,
                      value: hdlCount ?? 0.0,
                      lastWeekValue: lastWeekHdl,
                      isSvg: false,
                      isShow: true,
                      isShowCriteria: true,
                      lowerBand: 45
                    ),
                    LogsHistoryCard(
                      title: AppStrings.ldlText,
                      unit: AppStrings.mgPerDlText,
                      pngPath: AppImages.ldlImage,
                      value: ldlCount ?? 0.0,
                      lastWeekValue: lastWeekLdl,
                      isSvg: false,
                      isShow: true,
                      isShowCriteria: true,
                      upperBand: 160
                    ),
                    if (stepCount == null &&
                        weightCount == null &&
                        waistLineCount == null &&
                        hdlCount == null &&
                        ldlCount == null)
                      Center(
                        child: Text(
                          AppStrings.noDataForWeekText,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: AppColors.darkGrayColor),
                        ),
                      ),
                  ],
                );
              } else if (state is LogsError) {
                return const Center(
                    child: Text(AppStrings.errorLoadingLogsText));
              }
              return const Center(child: Text(AppStrings.noLogsAvailableText));
            },
          ),
        ],
      ),
    );
  }

  // Helper function to get log value from a list of logs
  double? getLogValue(List<LogsWeeklyRequestModel?> logs, String logName) {
    return logs
        .firstWhere(
          (log) => log?.logName == logName,
          orElse: () => null,
        )
        ?.value;
  }
}
