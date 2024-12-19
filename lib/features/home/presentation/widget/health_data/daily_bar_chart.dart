import 'package:flutter/material.dart';
import 'package:wellwave_frontend/features/home/presentation/widget/health_data/bar_chart_painter.dart';
import 'package:wellwave_frontend/features/home/presentation/widget/health_data/mock_data.dart';

class DailyBarChart extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  const DailyBarChart({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<int> weeklyAverages = _calculateWeeklyAverages(mockData);

    return Column(
      children: [
        CustomPaint(
          size: Size(double.infinity, 64),
          painter: BarChartPainter(
            data: mockData,
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
