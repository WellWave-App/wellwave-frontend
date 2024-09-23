import 'package:flutter/material.dart';
import 'package:wellwave_frontend/common/widget/app_bar.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/mission/presentation/widgets/overview_daily.dart';

class DailyTaskPage extends StatelessWidget {
  const DailyTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        title: AppStrings.dailyTaskText,
        backgroundColor: AppColors.backgroundColor,
        onLeading: true,
      ),
      body: const Column(
        children: [
          OverviewDaily(),
        ],
      ),
    );
  }
}
