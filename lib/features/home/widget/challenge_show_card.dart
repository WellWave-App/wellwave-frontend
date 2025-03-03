import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wellwave_frontend/common/widget/custom_button.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_pages.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/home/data/models/challenge.dart';

class ChallengeShowCard extends StatelessWidget {
  final Challenge challenge;

  const ChallengeShowCard({super.key, required this.challenge});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.4,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(
            challenge.image,
            width: 64,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.image_not_supported, size: 64);
            },
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (challenge.rewardType == 'EXP')
                SvgPicture.asset(
                  AppImages.expIcon,
                  height: 20,
                ),
              if (challenge.rewardType == 'GEM')
                SvgPicture.asset(
                  AppImages.gemIcon,
                  height: 20,
                ),
              const SizedBox(width: 4),
              Text(
                challenge.points.toString(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.blackColor,
                    ),
              ),
              const SizedBox(width: 4),
              Text(
                challenge.rewardType,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.blackColor,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 72,
            child: Text(
              challenge.taskDescription,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.blackColor,
                  ),
            ),
          ),
          const SizedBox(height: 16),
          CardButton(
            buttonText: AppStrings.seeMissionText,
            onPressed: () {
              context.goNamed(AppPages.missionPage);
            },
          ),
        ],
      ),
    );
  }
}
