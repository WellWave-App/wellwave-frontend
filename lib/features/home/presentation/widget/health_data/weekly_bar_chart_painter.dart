import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'dart:ui' as ui;

import 'package:wellwave_frontend/features/home/presentation/widget/health_data/thai_date_formatter.dart';

class WeeklyBarChartPainter extends CustomPainter {
  final List<Map<String, dynamic>> data;
  final List<int> weeklyAverages;
  final BuildContext context;

  WeeklyBarChartPainter({
    required this.data,
    required this.weeklyAverages,
    required this.context,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double maxHeight = 64;

    // คำนวณค่าเฉลี่ยรายสัปดาห์
    List<double> weeklyAverages = [];
    for (int i = 0; i < data.length; i += 7) {
      int end = (i + 7 < data.length) ? i + 7 : data.length;
      List<Map<String, dynamic>> weeklyData = data.sublist(i, end);
      double weeklyAverage =
          weeklyData.fold(0.0, (sum, item) => sum + item['value'].toDouble()) /
              weeklyData.length;
      weeklyAverages.add(weeklyAverage);
    }

    double maxData =
        weeklyAverages.fold(0.0, (max, value) => value > max ? value : max);

    double barWidth = size.width / weeklyAverages.length;

    for (int i = 0; i < weeklyAverages.length; i++) {
      bool isRecentWeek = i == weeklyAverages.length - 1;

      Paint barPaint = Paint()
        ..color = isRecentWeek ? AppColors.green25Color : AppColors.gray50Color;

      double barHeight = (weeklyAverages[i] / maxData) * maxHeight;

      canvas.drawRect(
        Rect.fromLTWH(
            i * barWidth, size.height - barHeight, barWidth - 4, barHeight),
        barPaint,
      );
    }

    num recentAverage = weeklyAverages.isNotEmpty
        ? (weeklyAverages.last.toDouble()).ceil()
        : 0.0;

    double overallAverage = weeklyAverages.isNotEmpty
        ? weeklyAverages.reduce((a, b) => a + b) / weeklyAverages.length
        : 0.0;

    Paint recentAveragePaint = Paint()
      ..color = AppColors.greenColor
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    Paint overallAveragePaint = Paint()
      ..color = AppColors.grayColor
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    double recentAverageHeight = (recentAverage / maxData) * maxHeight;
    double recentStartX = (weeklyAverages.length - 1) * barWidth;
    double recentEndX = recentStartX + barWidth;

    canvas.drawLine(
      Offset(recentStartX, size.height - recentAverageHeight),
      Offset(recentEndX, size.height - recentAverageHeight),
      recentAveragePaint,
    );

    // วาดข้อความค่าเฉลี่ยของ 7 วันล่าสุด
    TextPainter recentTextPainter = TextPainter(
      text: TextSpan(
        text: 'เฉลี่ย ${recentAverage.toInt()} นาที',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.greenColor,
              fontWeight: FontWeight.bold,
            ),
      ),
      textDirection: ui.TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);

    double recentTextX = size.width - recentTextPainter.width;

    double recentTextY = size.height - recentAverageHeight - 20;
    double overallAverageHeight = (overallAverage / maxData) * maxHeight;
    double overallStartX = 0;
    double overallEndX = (weeklyAverages.length - 1) * barWidth;

    canvas.drawLine(
      Offset(overallStartX, size.height - overallAverageHeight),
      Offset(overallEndX, size.height - overallAverageHeight),
      overallAveragePaint,
    );

    recentTextPainter.paint(canvas, Offset(recentTextX, recentTextY));

    TextPainter overallTextPainter = TextPainter(
      text: TextSpan(
        text: 'เฉลี่ย ${overallAverage.toInt()} นาที',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.grayColor,
              fontWeight: FontWeight.bold,
            ),
      ),
      textDirection: ui.TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);

    double overallTextX = overallStartX;
    double overallTextY = size.height - overallAverageHeight - 20;

    overallTextPainter.paint(canvas, Offset(overallTextX, overallTextY));

    // วาดข้อความช่วงวันที่ใต้กราฟ
    DateTime firstDateOfRecentWeek =
        DateFormat('dd-MM-yyyy').parse(data[data.length - 7]['date']);
    DateTime lastDateOfRecentWeek =
        DateFormat('dd-MM-yyyy').parse(data[data.length - 1]['date']);
    String recentWeekDateRange = ThaiDateFormatter.formatDateRange(
        firstDateOfRecentWeek, lastDateOfRecentWeek);

    TextPainter recentWeekDateTextPainter = TextPainter(
      text: TextSpan(
        text: recentWeekDateRange,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.greenColor,
              fontWeight: FontWeight.bold,
            ),
      ),
      textDirection: ui.TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);

    double recentWeekDateX =
        size.width - barWidth / 2 - recentWeekDateTextPainter.width / 2;
    recentWeekDateTextPainter.paint(
        canvas, Offset(recentWeekDateX, size.height + 4));

    // วันที่ของกราฟที่เหลือ (ก่อนสัปดาห์ล่าสุด)
    if (data.length > 7) {
      DateTime firstDateOfRemaining =
          DateFormat('dd-MM-yyyy').parse(data[0]['date']);
      DateTime lastDateOfRemaining =
          DateFormat('dd-MM-yyyy').parse(data[data.length - 8]['date']);
      String remainingDateRange = ThaiDateFormatter.formatDateRange(
          firstDateOfRemaining, lastDateOfRemaining);

      TextPainter remainingDateTextPainter = TextPainter(
        text: TextSpan(
          text: remainingDateRange,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.grayColor,
                fontWeight: FontWeight.bold,
              ),
        ),
        textDirection: ui.TextDirection.ltr,
      )..layout(minWidth: 0, maxWidth: double.infinity);

      double remainingDateX =
          (size.width - barWidth) / 2 - remainingDateTextPainter.width / 2;

      remainingDateTextPainter.paint(
          canvas, Offset(remainingDateX, size.height + 4));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    if (oldDelegate is WeeklyBarChartPainter) {
      return oldDelegate.data != data ||
          oldDelegate.weeklyAverages != weeklyAverages;
    }
    return false;
  }
}
