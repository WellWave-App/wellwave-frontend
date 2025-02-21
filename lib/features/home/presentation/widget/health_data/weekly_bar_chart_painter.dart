import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'dart:ui' as ui;

import 'package:wellwave_frontend/config/constants/enums/thai_date_formatter.dart';

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

    double maxData = weeklyAverages.fold<double>(0.0, (double max, int value) {
      return (value > max ? value : max).toDouble();
    });

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
        ? weeklyAverages
                .take(weeklyAverages.length - 1)
                .fold(0.0, (a, b) => a + b) /
            (weeklyAverages.length - 1)
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
    double recentEndX = recentStartX + barWidth - 4;

    Path recentAveragePath = Path();
    double distance = 0.0;
    while (distance < recentEndX - recentStartX) {
      recentAveragePath.moveTo(
          recentStartX + distance, size.height - recentAverageHeight);
      distance += 8.0;
      recentAveragePath.lineTo(
          recentStartX + distance, size.height - recentAverageHeight);
      distance += 5.0;
    }
    canvas.drawPath(recentAveragePath, recentAveragePaint);

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

    recentTextPainter.paint(canvas, Offset(recentTextX, recentTextY));

    double overallAverageHeight = (overallAverage / maxData) * maxHeight;
    double overallStartX = 0;
    double overallEndX = (weeklyAverages.length - 1) * barWidth - 4;

    Path overallAveragePath = Path();
    distance = 0.0;
    while (distance < overallEndX - overallStartX) {
      overallAveragePath.moveTo(
          overallStartX + distance, size.height - overallAverageHeight);
      distance += 8.0;
      overallAveragePath.lineTo(
          overallStartX + distance, size.height - overallAverageHeight);
      distance += 5.0;
    }
    canvas.drawPath(overallAveragePath, overallAveragePaint);

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

    DateTime firstDateOfRecentWeek =
        DateFormat('yyyy-MM-dd HH:mm:ss').parse(data[data.length - 7]['date']);
    DateTime lastDateOfRecentWeek =
        DateFormat('yyyy-MM-dd HH:mm:ss').parse(data[data.length - 1]['date']);

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

    double recentWeekDateX = size.width - recentWeekDateTextPainter.width;
    recentWeekDateTextPainter.paint(
        canvas, Offset(recentWeekDateX, size.height + 4));
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
