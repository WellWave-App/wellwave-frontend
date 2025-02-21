import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'dart:ui' as ui;

import 'package:wellwave_frontend/config/constants/enums/thai_date_formatter.dart';

class DailyBarChartPainter extends CustomPainter {
  final List<Map<String, dynamic>> data;
  final List<int> weeklyAverages;
  final BuildContext context;

  DailyBarChartPainter({
    required this.data,
    required this.weeklyAverages,
    required this.context,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double maxHeight = 64;

    List<Map<String, dynamic>> completeData = _fillMissingDays(data);

    double maxData = completeData.fold(
        0.0,
        (max, item) =>
            item['value'].toDouble() > max ? item['value'].toDouble() : max);

    maxData = maxData > 0 ? maxData : 1;

    double barWidth = size.width / 7;

    for (int i = 0; i < completeData.length; i++) {
      bool isRecentWeek = i >= completeData.length - 7;

      Paint barPaint = Paint()
        ..color = isRecentWeek ? AppColors.green25Color : AppColors.gray50Color;

      double barHeight =
          (completeData[i]['value'].toDouble() / maxData) * maxHeight;
      if (barHeight.isNaN || barHeight <= 0) {
        barHeight = 0;
      }

      canvas.drawRect(
        Rect.fromLTWH(
            i * barWidth, size.height - barHeight, barWidth - 4, barHeight),
        barPaint,
      );
    }

    double recentStartX = (completeData.length - 7) * barWidth;
    double recentEndX = completeData.length * barWidth - 4;

    DateTime firstDate = DateFormat('dd-MM-yyyy')
        .parse(completeData[completeData.length - 7]['date']);
    DateTime lastDate = DateFormat('dd-MM-yyyy')
        .parse(completeData[completeData.length - 1]['date']);

    String dateRangeText =
        ThaiDateFormatter.formatDateRange(firstDate, lastDate);

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
  }

  List<Map<String, dynamic>> _fillMissingDays(List<Map<String, dynamic>> data) {
    List<Map<String, dynamic>> completedData = [];

    Map<String, Map<String, dynamic>> formattedData = {
      for (var entry in data)
        DateFormat('dd-MM-yyyy')
            .format(DateTime.parse(entry['date'].toString())): {
          'date': DateFormat('dd-MM-yyyy')
              .format(DateTime.parse(entry['date'].toString())),
          'value': entry['value']
        }
    };

    DateTime today = DateTime.now();
    DateTime thisWeekSunday = today
        .subtract(Duration(days: today.weekday))
        .subtract(Duration(days: 7));

    for (int i = 6; i >= 0; i--) {
      DateTime date = thisWeekSunday.add(Duration(days: i));
      String formattedDate = DateFormat('dd-MM-yyyy').format(date);

      if (formattedData.containsKey(formattedDate)) {
        completedData.add(formattedData[formattedDate]!);
      } else {
        completedData.add({'date': formattedDate, 'value': 0});
      }
    }

    completedData.sort((a, b) {
      DateTime dateA = DateFormat('dd-MM-yyyy').parse(a['date']);
      DateTime dateB = DateFormat('dd-MM-yyyy').parse(b['date']);
      return dateA.compareTo(dateB);
    });
    // print(completedData);
    return completedData;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    if (oldDelegate is DailyBarChartPainter) {
      return oldDelegate.data != data ||
          oldDelegate.weeklyAverages != weeklyAverages;
    }
    return false;
  }
}
