import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_pages.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import '../../../../common/widget/app_bar.dart';

class MissionScreen extends StatelessWidget {
  const MissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        title: AppStrings.emptyText,
        backgroundColor: AppColors.whiteColor,
        onLeading: false,
        rightText: AppStrings.historyText,
        onRightPressed: () {},
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.iDoTodayText,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              Text(
                AppStrings.chooseActivityText,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 36),
              _buildActivityButton(
                context,
                AppStrings.dailyTaskText,
                AppImages.dailyTaskImage,
                AppPages.dailyTaskName,
                AppColors.secondaryDarkColor,
              ),
              const SizedBox(height: 24),
              _buildActivityButton(
                context,
                AppStrings.habitChallengeText,
                AppImages.habitChallengeImage,
                AppPages.habitChallengeName,
                AppColors.mintColor,
              ),
              const SizedBox(height: 24),
              _buildActivityButton(
                context,
                AppStrings.questText,
                AppImages.questImage,
                AppPages.questName,
                AppColors.pinkColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityButton(BuildContext context, String title,
      String imagePath, String routeName, Color color) {
    return GestureDetector(
      onTap: () {
        context.goNamed(routeName); // Use goNamed to navigate by route name
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        height: 100,
        child: Row(
          children: [
            Image.asset(
              imagePath,
              width: 80, // Ensure consistent image width
              height: 80,
              fit: BoxFit.cover, // Adjust image fit for better display
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.whiteColor,
                    ),
                overflow: TextOverflow.ellipsis, // Handle text overflow
                maxLines: 2,
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              size: 50,
              color: AppColors.whiteColor,
            ),
          ],
        ),
      ),
    );
  }
}
