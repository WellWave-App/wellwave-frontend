import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProgressCard extends StatelessWidget {
  final int daysRemain;
  final int exerciseTime;
  final int taskAmount;
  final int stepAmount;
  final int maxExerciseTime;
  final int maxTaskAmount;
  final int maxStepCount;

  const ProgressCard({
    Key? key,
    required this.daysRemain,
    required this.exerciseTime,
    required this.taskAmount,
    required this.maxExerciseTime,
    required this.maxTaskAmount,
    required this.maxStepCount,
    required this.stepAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int weekday = DateTime.now().weekday;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.whiteColor,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                const SizedBox(height: 16),
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
                          weekday != 7
                              ? 'อีก $daysRemain ${AppStrings.dayText}'
                              : 'วันสุดท้าย',
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.amoutOfStepText,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        LinearPercentIndicator(
                          width: 182.0,
                          lineHeight: 6.0,
                          percent:
                              maxStepCount != 0 ? stepAmount / maxStepCount : 0,
                          backgroundColor: Colors.grey.shade100,
                          progressColor: AppColors.primaryColor,
                        ),
                        Row(
                          children: [
                            Text(
                              '$stepAmount ',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '/$maxStepCount ${AppStrings.stepText}',
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
                const SizedBox(height: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.exerciseProgressText,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        LinearPercentIndicator(
                          width: 182.0,
                          lineHeight: 6.0,
                          percent: exerciseTime / maxExerciseTime,
                          backgroundColor: Colors.grey.shade100,
                          progressColor: AppColors.primaryColor,
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
                const SizedBox(height: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.taskProgressText,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        LinearPercentIndicator(
                          width: 182.0,
                          lineHeight: 6.0,
                          percent: taskAmount / maxTaskAmount,
                          backgroundColor: Colors.grey.shade100,
                          progressColor: AppColors.primaryColor,
                        ),
                        Row(
                          children: [
                            Text(
                              '$taskAmount ',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '/$maxTaskAmount ${AppStrings.taskText}',
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
              ],
            ),
          ),
          SvgPicture.asset(AppImages.progressBgSvg)
        ],
      ),
    );
  }
}
