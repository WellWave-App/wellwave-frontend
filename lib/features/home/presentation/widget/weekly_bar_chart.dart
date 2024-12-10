import 'package:flutter/material.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';

class WeeklyBarChart extends StatelessWidget {
  final List<int> data;

  const WeeklyBarChart({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double average = data.reduce((a, b) => a + b) / data.length;

    int roundedAverage = average.toInt();

    return Stack(
      children: [
        CustomPaint(
          size: Size(double.infinity, 64),
          painter: BarChartPainter(
            data: data,
            average: roundedAverage,
            context: context,
          ),
        ),
        Positioned(
          top: 64 -
              ((roundedAverage / data.reduce((a, b) => a > b ? a : b)) * 64) -
              24,
          child: Center(
            child: Text(
              'เฉลี่ย $roundedAverage นาที',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppColors.greenColor,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}

class BarChartPainter extends CustomPainter {
  final List<int> data;
  final int average;
  final BuildContext context;

  BarChartPainter(
      {required this.data, required this.average, required this.context});

  @override
  void paint(Canvas canvas, Size size) {
    double maxHeight = 64;
    double maxData = data.reduce((a, b) => a > b ? a : b).toDouble();

    Paint barPaint = Paint()..color = AppColors.gray50Color;
    Paint averagePaint = Paint()
      ..color = AppColors.greenColor
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    double barWidth = size.width / data.length;

    for (int i = 0; i < data.length; i++) {
      double barHeight = (data[i] / maxData) * maxHeight;
      canvas.drawRect(
        Rect.fromLTWH(
            i * barWidth, size.height - barHeight, barWidth - 4, barHeight),
        barPaint,
      );
    }
    double averageHeight = (average / maxData) * maxHeight;
    canvas.drawLine(
      Offset(0, size.height - averageHeight),
      Offset(size.width, size.height - averageHeight),
      averagePaint,
    );

    List<String> days = ['จ', 'อ', 'พ', 'พฤ', 'ศ', 'ส', 'อา'];

    for (int i = 0; i < data.length; i++) {
      TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: days[i],
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.grayColor,
              ),
        ),
        textDirection: TextDirection.ltr,
      )..layout(minWidth: 0, maxWidth: double.infinity);

      double xPosition =
          i * barWidth + (barWidth / 2) - (textPainter.width / 2);
      double yPosition = size.height + 4;

      textPainter.paint(canvas, Offset(xPosition, yPosition));
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
