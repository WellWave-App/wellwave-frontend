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
        actionIcon: Text(
          AppStrings.historyText,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.darkGrayColor,
              ),
        ),
        action: () {},
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
                AppPages.questDetailName,
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
        context.goNamed(routeName);
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 28.0),
                  child: Image.asset(
                    imagePath,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppColors.whiteColor,
                      ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.left, // ให้ text ชิดซ้าย
                ),
              ],
            ),
            const Padding(
              padding:
                  EdgeInsets.only(right: 16.0), // เพิ่ม padding ขวาให้กับไอคอน
              child: Icon(
                Icons.chevron_right_rounded,
                size: 50,
                color: AppColors.whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
