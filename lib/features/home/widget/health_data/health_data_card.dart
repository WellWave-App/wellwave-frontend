import 'package:flutter/material.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/features/home/widget/health_data/bar_chart.dart';
import 'package:wellwave_frontend/features/home/widget/health_data/mock_data.dart';

class HealthDataCard extends StatelessWidget {
  final List<int> weeklyAverages;

  const HealthDataCard({super.key, required this.weeklyAverages});
  // debugPrint(weeklyAverages);

  @override
  Widget build(BuildContext context) {
    bool isLessThanPrevious = weeklyAverages.length > 1 &&
        weeklyAverages.last < weeklyAverages[weeklyAverages.length - 2];

    String message = isLessThanPrevious
        ? 'คุณใช้เวลาออกกำลังกายเฉลี่ย ${weeklyAverages.last} นาทีในสัปดาห์นี้ หยุดพักแล้วอย่าลืมกลับมาสู้ต่อ!'
        : 'คุณใช้เวลาออกกำลังกายเฉลี่ย ${weeklyAverages.last} นาทีในสัปดาห์นี้ อย่าลืมรักษาความต่อเนื่องนี้ไว้!';

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
            message,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.blackColor,
                ),
          ),
          SizedBox(height: 16),
          BarChart(data: mockData),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
