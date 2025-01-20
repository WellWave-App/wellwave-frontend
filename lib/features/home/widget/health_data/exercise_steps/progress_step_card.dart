import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wellwave_frontend/common/widget/progress_bar_widget.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/home/data/models/progress_step_ex.dart';

class ProgressStepCard extends StatelessWidget {
  final ProgressStepEx progressStepExData;

  const ProgressStepCard({
    Key? key,
    required this.progressStepExData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProgressBarWidget(
                currentValue: progressStepExData.currentSteps,
                targetValue: progressStepExData.goalSteps,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                AppStrings.stepText,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 8),
              Text(
                '${progressStepExData.currentSteps}',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondaryDarkColor,
                    ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: SvgPicture.asset(
              AppImages.stepImage,
              height: 24,
            ),
          ),
        ],
      ),
    );
  }
}
