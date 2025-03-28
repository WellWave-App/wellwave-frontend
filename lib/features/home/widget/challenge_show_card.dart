import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wellwave_frontend/common/widget/custom_button.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_pages.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/config/constants/app_url.dart';
import 'package:wellwave_frontend/features/home/data/models/recommend_habit_response_model.dart';

class HabitShowCard extends StatelessWidget {
  final HabitSimpleModel habit;

  const HabitShowCard({Key? key, required this.habit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withOpacity(0.1),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            "$baseUrl/${habit.thumbnailUrl}",
            height: 64,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.image_not_supported, size: 64);
            },
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 48,
            child: Text(
              habit.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.blackColor,
                  ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              if (habit.expReward != 0) ...[
                SvgPicture.asset(
                  AppImages.expIcon,
                  height: 20,
                ),
                const SizedBox(width: 4),
                Text(
                  "${habit.expReward.toString()} ${AppStrings.expText.toUpperCase()}",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.blackColor,
                      ),
                ),
              ] else if (habit.gemReward != 0) ...[
                SvgPicture.asset(
                  AppImages.gemIcon,
                  height: 20,
                ),
                const SizedBox(width: 4),
                Text(
                  "${habit.gemReward.toString()} ${AppStrings.gemText.toUpperCase()}",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.blackColor,
                      ),
                ),
              ],
            ],
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
