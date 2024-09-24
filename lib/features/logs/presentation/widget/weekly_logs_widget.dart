import 'package:flutter/material.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/logs/presentation/widget/logs_history_card.dart';

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