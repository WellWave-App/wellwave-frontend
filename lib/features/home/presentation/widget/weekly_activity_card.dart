import 'package:flutter/material.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/features/home/presentation/widget/weekly_bar_chart.dart';

class WeeklyActivityCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
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
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ดึง นาที
            Text(
              'คุณใช้เวลาออกกำลังกายเฉลี่ย 6 นาทีในสัปดาห์นี้\nอย่าลืมรักษาความต่อเนื่องนี้ไว้!',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.blackColor,
                  ),
            ),
            SizedBox(height: 16),
            WeeklyBarChart(),
          ],
        ),
      ),
    );
  }
}
