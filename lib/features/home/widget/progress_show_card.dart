import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wellwave_frontend/common/widget/custom_button.dart';
import 'package:wellwave_frontend/common/widget/gradient_circular_progress_indicator.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_pages.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/home/data/models/progress.dart';

class ProgressShowCard extends StatelessWidget {
  final Progress progress;

  const ProgressShowCard({Key? key, required this.progress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.5,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 4,
                child: Text(
                  progress.taskDescription,
                  textAlign: TextAlign.left,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: AppColors.blackColor,
                      ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                flex: 1,
                child: GradientCircularProgressWithText(
                  value: progress.progress,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              if (progress.rewardType == 'EXP')
                SvgPicture.asset(
                  AppImages.expIcon,
                  height: 20,
                ),
              if (progress.rewardType == 'GEM')
                SvgPicture.asset(
                  AppImages.gemIcon,
                  height: 20,
                ),
              const SizedBox(
                width: 4,
              ),
              Text(
                progress.rewards.toString(),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.blackColor,
                    ),
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                progress.rewardType,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.blackColor,
                    ),
              ),
            ],
          ),
          SizedBox(height: 16),
          CardButton(
            buttonText: AppStrings.continueMissionText,
            onPressed: () {
              context.goNamed(AppPages.missionPage);
            },
          ),
        ],
      ),
    );
  }
}
