import 'package:flutter/material.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/features/home/presentation/widget/health_data/daily_bar_chart.dart';
import 'package:wellwave_frontend/features/home/presentation/widget/health_data/weekly_bar_chart.dart';
import 'package:wellwave_frontend/features/home/presentation/widget/health_data/mock_data.dart';

class HealthDataCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<int> calculateWeeklyAverages(List<Map<String, dynamic>> data) {
      List<int> weeklyAverages = [];
      int weekSum = 0;
      int dayCount = 0;

      for (int i = 0; i < data.length; i++) {
        weekSum += data[i]['value'] as int;
        dayCount++;

        if (dayCount == 7 || i == data.length - 1) {
          int average = (weekSum / dayCount).round();
          weeklyAverages.add(average);

          weekSum = 0;
          dayCount = 0;
        }
      }

      return weeklyAverages;
    }

    List<int> weeklyAverages = calculateWeeklyAverages(mockData);

    int totalValue =
        mockData.fold<int>(0, (sum, item) => sum + (item['value'] as int));

    print(totalValue);

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
            'คุณใช้เวลาออกกำลังกายเฉลี่ย ${weeklyAverages.last} นาทีในสัปดาห์นี้\nอย่าลืมรักษาความต่อเนื่องนี้ไว้!',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.blackColor,
                ),
          ),
          SizedBox(height: 16),
          totalValue >= 28
              ? WeeklyBarChart(data: mockData)
              : DailyBarChart(data: mockData),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
