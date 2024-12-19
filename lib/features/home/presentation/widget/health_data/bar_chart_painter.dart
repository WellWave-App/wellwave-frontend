import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'dart:ui' as ui;

class BarChartPainter extends CustomPainter {
  final List<Map<String, dynamic>> data;
  final List<int> weeklyAverages;
  final BuildContext context;

  BarChartPainter({
    required this.data,
    required this.weeklyAverages,
    required this.context,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double maxHeight = 64;
    double maxData = data.fold(
        0.0,
        (max, item) =>
            item['value'].toDouble() > max ? item['value'].toDouble() : max);

    double barWidth = size.width / data.length;

    // วาดแถบแท่ง
    for (int i = 0; i < data.length; i++) {
      bool isRecentWeek = i >= data.length - 7;

      Paint barPaint = Paint()
        ..color = isRecentWeek ? AppColors.green25Color : AppColors.gray50Color;

      double barHeight = (data[i]['value'].toDouble() / maxData) * maxHeight;
      canvas.drawRect(
        Rect.fromLTWH(
            i * barWidth, size.height - barHeight, barWidth - 4, barHeight),
        barPaint,
      );
    }

    // คำนวณค่าเฉลี่ยของ 7 วันล่าสุด
    double recentAverage =
        weeklyAverages.isNotEmpty ? weeklyAverages.last.toDouble() : 0.0;

    // คำนวณค่าเฉลี่ยทั้งหมด
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
    double recentStartX = (data.length - 7) * barWidth;
    double recentEndX = data.length * barWidth;

    canvas.drawLine(
      Offset(recentStartX, size.height - recentAverageHeight),
      Offset(recentEndX, size.height - recentAverageHeight),
      recentAveragePaint,
    );

    // วาดช่วงวันที่ของ 7 วันล่าสุด
    DateTime firstDate =
        DateFormat('dd-MM-yyyy').parse(data[data.length - 7]['date']);
    DateTime lastDate =
        DateFormat('dd-MM-yyyy').parse(data[data.length - 1]['date']);

    String dateRangeText =
        "${DateFormat('d').format(firstDate)}-${DateFormat('d MMM').format(lastDate)}";

    TextPainter dateTextPainter = TextPainter(
      text: TextSpan(
        text: dateRangeText,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.greenColor,
              fontWeight: FontWeight.bold,
            ),
      ),
      textDirection: ui.TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);

    double centerX = recentStartX +
        ((recentEndX - recentStartX) / 2) -
        (dateTextPainter.width / 2);

    dateTextPainter.paint(canvas, Offset(centerX, size.height + 4));

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

    recentTextPainter.paint(canvas, Offset(recentTextX, recentTextY));

    // วาดช่วงวันที่ของแท่งที่เหลือ
    if (data.length > 7) {
      DateTime firstDateOfRemaining =
          DateFormat('dd-MM-yyyy').parse(data[0]['date']);
      DateTime lastDateOfRemaining =
          DateFormat('dd-MM-yyyy').parse(data[data.length - 8]['date']);

      String remainingDateRangeText =
          "${DateFormat('d').format(firstDateOfRemaining)}-${DateFormat('d MMM').format(lastDateOfRemaining)}";

      TextPainter remainingDateTextPainter = TextPainter(
        text: TextSpan(
          text: remainingDateRangeText,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.grayColor,
                fontWeight: FontWeight.bold,
              ),
        ),
        textDirection: ui.TextDirection.ltr,
      )..layout(minWidth: 0, maxWidth: double.infinity);

      // คำนวณตำแหน่งกลางของแท่งที่เหลือ
      double remainingStartX = 0;
      double remainingEndX = (data.length - 7) * barWidth;

      double remainingCenterX = remainingStartX +
          ((remainingEndX - remainingStartX) / 2) -
          (remainingDateTextPainter.width / 2);

      remainingDateTextPainter.paint(canvas,
          Offset(remainingCenterX, size.height + 4)); // ตำแหน่งวางข้อความ
    }

    double overallAverageHeight = (overallAverage / maxData) * maxHeight;
    double overallStartX = 0;
    double overallEndX = (data.length - 7) * barWidth;

    canvas.drawLine(
      Offset(overallStartX, size.height - overallAverageHeight),
      Offset(overallEndX, size.height - overallAverageHeight),
      overallAveragePaint,
    );

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
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    if (oldDelegate is BarChartPainter) {
      return oldDelegate.data != data ||
          oldDelegate.weeklyAverages != weeklyAverages;
    }
    return false;
  }
}
