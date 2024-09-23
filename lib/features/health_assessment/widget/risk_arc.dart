import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:wellwave_frontend/config/constants/enums/risk_condition.dart';

class RiskArc extends CustomPainter {
  final double percentage; // ควรอยู่ระหว่าง 0.0 ถึง 1.0

  RiskArc({required this.percentage});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16;

    paint.color = Colors.grey[300]!;
    canvas.drawArc(
      Rect.fromCenter(
          center: Offset(size.width / 2, size.height),
          width: size.width,
          height: size.width),
      math.pi,
      math.pi,
      false,
      paint,
    );

    paint.shader = LinearGradient(
      colors: [
        Color.fromARGB(255, 56, 208, 190),
        Color.fromARGB(255, 155, 202, 146),
        Color.fromARGB(255, 255, 196, 102),
        Color.fromARGB(255, 255, 162, 135),
        Color.fromARGB(255, 255, 128, 169),
      ],
      stops: [0.0, 0.25, 0.5, 0.75, 1.0],
    ).createShader(Rect.fromCircle(
        center: Offset(size.width / 2, size.height), radius: size.width / 2));

    canvas.drawArc(
      Rect.fromCenter(
          center: Offset(size.width / 2, size.height),
          width: size.width,
          height: size.width),
      math.pi,
      math.pi * percentage,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class GaugeWidget extends StatefulWidget {
  final double averageRiskScore;

  GaugeWidget({required this.averageRiskScore});

  @override
  _GaugeWidgetState createState() => _GaugeWidgetState();
}

class _GaugeWidgetState extends State<GaugeWidget> {
  @override
  Widget build(BuildContext context) {
    final riskText =
        RiskTextCondition.getRiskTextFromAverage(widget.averageRiskScore);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              size: Size(MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.width / 2),
              painter: RiskArc(percentage: widget.averageRiskScore),
            ),
            Positioned(
              bottom: 24,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "ภาวะเมตาบอลิกซินโดรมของคุณ",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Colors.black),
                  ),
                  SizedBox(height: 12),
                  Text(
                    riskText['text'],
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
