import 'package:flutter/material.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';

class ProgressCard extends StatelessWidget {
  final int daysRemain;
  final int exerciseTime;
  final int taskAmount;
  final int maxExerciseTime;
  final int maxTaskAmount;

  const ProgressCard({
    Key? key,
    required this.daysRemain,
    required this.exerciseTime,
    required this.taskAmount,
    required this.maxExerciseTime,
    required this.maxTaskAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.whiteColor,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.progressText,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.timelapse_rounded,
                    color: Colors.red,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'อีก $daysRemain ${AppStrings.dayText}',
                    style: Theme.of(context)
                        .textTheme
                        .caption2
                        ?.copyWith(color: Colors.red),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.exerciseProgressText,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(),
              ),
              Row(
                children: [
                  Text(
                    '$exerciseTime ',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '/$maxExerciseTime ${AppStrings.minuteText}',
                    style: Theme.of(context)
                        .textTheme
                        .caption2
                        ?.copyWith(color: AppColors.darkGrayColor),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.exerciseProgressText,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(),
              ),
              Row(
                children: [
                  Text(
                    '$exerciseTime ',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '/$maxExerciseTime ${AppStrings.minuteText}',
                    style: Theme.of(context)
                        .textTheme
                        .caption2
                        ?.copyWith(color: AppColors.darkGrayColor),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
