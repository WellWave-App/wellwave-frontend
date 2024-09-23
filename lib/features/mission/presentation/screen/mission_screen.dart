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
        backgroundColor: AppColors.backgroundColor,
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
              Text(AppStrings.iDoTodayText,
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              Text(AppStrings.chooseActivityText,
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 36),
              _buildActivityButton(context, AppStrings.dailyTaskEnterText,
                  AppImages.emptyComponentImage, AppPages.dailyTaskName),
              const SizedBox(height: 24),
              _buildActivityButton(context, AppStrings.habitChallengeEnterText,
                  AppImages.emptyComponentImage, AppPages.habitChallengeName),
              const SizedBox(height: 24),
              _buildActivityButton(context, AppStrings.questText,
                  AppImages.emptyComponentImage, AppPages.questName),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityButton(
      BuildContext context, String title, String imagePath, String routeName) {
    double containerWidth = MediaQuery.of(context).size.width;
    return Container(
      width: containerWidth,
      decoration: BoxDecoration(
        color: AppColors.baseGrayColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 24.0),
        child: ListTile(
          leading: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Image.asset(
              imagePath,
              width: 60,
              height: 60,
            ),
          ),
          title: Text(title, style: Theme.of(context).textTheme.labelLarge),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            context.goNamed(routeName);
          },
        ),
      ),
    );
  }
}
