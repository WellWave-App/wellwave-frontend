import 'package:flutter/material.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/features/home/presentation/widget/month_bar_chart.dart';
import 'package:wellwave_frontend/features/home/presentation/widget/weekly_bar_chart.dart';
import 'package:flutter/services.dart';

class HealthDataMonthlyCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<int> dataMonth = [
      54,
      156,
      600,
      400,
      400,
      400,
      400,
      100,
      500,
      305,
      305,
      305,
      305,
      305,
      305,
      305,
      305,
      305,
      305,
      305,
      305,
      305,
      305,
      305
    ];
    int consecutiveWeeks = dataMonth.length;

    return Container(
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
          Text(
            'คุณใช้เวลาออกกำลังกายมากขึ้นติดต่อกัน $consecutiveWeeks สัปดาห์\nยอดเยี่ยมมาก คุณกำลังทำได้ดีขึ้นเรื่อย ๆ !',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.blackColor,
                ),
          ),
          SizedBox(height: 16),
          MonthBarChart(
            data: dataMonth,
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$consecutiveWeeks สัปดาห์',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.grayColor,
                    ),
              ),
              Text(
                '$consecutiveWeeks สัปดาห์',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.grayColor,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
