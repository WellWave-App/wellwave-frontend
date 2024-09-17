import 'package:flutter/material.dart';
import 'dart:math' as math;

class RiskArc extends CustomPainter {
  final double percentage;

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
        const Color.fromARGB(255, 56, 208, 190),
        const Color.fromARGB(255, 155, 202, 146),
        const Color.fromARGB(255, 255, 196, 102),
        const Color.fromARGB(255, 255, 162, 135),
        const Color.fromARGB(255, 255, 128, 169),
      ],
      stops: [0.0, 0.3, 0.6, 0.8, 1.0],
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
  final double percentage;

  GaugeWidget({required this.percentage});

  @override
  _GaugeWidgetState createState() => _GaugeWidgetState();
}

class _GaugeWidgetState extends State<GaugeWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              size: Size(MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.width / 2),
              painter: RiskArc(percentage: widget.percentage),
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
                    "มีความเสี่ยงสูง",
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
