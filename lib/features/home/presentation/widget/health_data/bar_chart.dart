import 'package:flutter/material.dart';
import 'package:wellwave_frontend/features/home/presentation/widget/health_data/daily_bar_chart_painter.dart';
import 'package:wellwave_frontend/features/home/presentation/widget/health_data/mock_data.dart';
import 'package:wellwave_frontend/features/home/presentation/widget/health_data/weekly_bar_chart_painter.dart';

class BarChart extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  const BarChart({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> latestData = mockData.length > 84
        ? mockData.sublist(mockData.length - 84)
        : mockData;

    List<int> weeklyAverages = _calculateWeeklyAverages(latestData);

    return Column(
      children: [
        CustomPaint(
          size: Size(double.infinity, 64),
          painter: latestData.length >= 28
              ? WeeklyBarChartPainter(
                  data: latestData,
                  weeklyAverages: weeklyAverages,
                  context: context,
                )
              : DailyBarChartPainter(
                  data: latestData,
                  weeklyAverages: weeklyAverages,
                  context: context,
                ),
        ),
      ],
    );
  }

  List<int> _calculateWeeklyAverages(List<Map<String, dynamic>> data) {
    List<int> weeklyAverages = [];
    double sum = 0.0;
    int count = 0;

    for (int i = 0; i < data.length; i++) {
      sum += data[i]['value'].toDouble();
      count++;

      if (count == 7 || i == data.length - 1) {
        weeklyAverages.add((sum / count).round());
        sum = 0.0;
        count = 0;
      }
    }

    return weeklyAverages;
  }
}
