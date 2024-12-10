import 'package:flutter/material.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/home/presentation/widget/health_data_monthly_card.dart';
import 'package:wellwave_frontend/features/home/presentation/widget/input_button.dart';
import 'package:wellwave_frontend/features/home/presentation/widget/health_data_weekly_card.dart';

class ProgressWidget extends StatelessWidget {
  const ProgressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.progressText,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: AppColors.blackColor,
                      ),
                ),
                InputButton(
                  buttonText: 'เพิ่ม',
                  onPressed: () {
                    print('Button Pressed');
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),

            Container(
              height: 130.0,
              alignment: Alignment.center,
              child: Text(
                'ยังไม่มีความคืบหน้า ไปเริ่มทำกันเลย!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.darkgrayColor,
                    ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              AppStrings.challengeText,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppColors.blackColor,
                  ),
            ),
            const SizedBox(height: 16),
            // Recommendation section
            Container(
              height: 130.0,
              alignment: Alignment.center,
              child: Text(
                'แนะนำภารกิจ',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.darkgrayColor,
                    ),
              ),
            ),
            Text(
              AppStrings.healthdataText,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppColors.blackColor,
                  ),
            ),
            const SizedBox(height: 16),
            // health data section
            Container(
              child: HealthDataMonthlyCard(),
            ),
          ],
        ),
      ),
    );
  }
}
