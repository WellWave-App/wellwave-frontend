import 'package:flutter/material.dart';
import 'package:wellwave_frontend/common/widget/app_bar.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';

class QuestPage extends StatelessWidget {
  const QuestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        title: AppStrings.questText,
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
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(100),
              ),
            ),
            height: MediaQuery.of(context).size.height * 0.15,
          ),
          const Column(
              // children: [SizedBox(height: 16), OverviewDaily()],
              )
        ],
      ),
    );
  }
}
