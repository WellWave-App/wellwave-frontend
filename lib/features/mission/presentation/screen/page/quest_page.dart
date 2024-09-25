import 'package:flutter/material.dart';
import 'package:wellwave_frontend/common/widget/app_bar.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/mission/presentation/widgets/overview_daily.dart';
import '../../../../../config/constants/app_images.dart';

class QuestPage extends StatelessWidget {
  const QuestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        title: AppStrings.dailyTaskText,
        backgroundColor: AppColors.pinkColor,
        titleColor: AppColors.whiteColor,
        textColor: AppColors.whiteColor,
        onLeading: true,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: AppColors.pinkColor,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(
                    100), // Set the desired radius for the bottom corners
              ),
            ),
            height: MediaQuery.of(context).size.height * 0.18,
          ),
          Column(
            children: [
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center items horizontally
                children: [
                  Text(
                    AppStrings.taskCompletedWithGemText,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.whiteColor,
                        ),
                  ),
                  Image.asset(
                    AppImages.gemImage, // Show image
                    width: 24, // Set image size
                    height: 24,
                  ),
                  Text(
                    ' x15',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.whiteColor,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const OverviewDaily()
            ],
          )
        ],
      ),
    );
  }
}
