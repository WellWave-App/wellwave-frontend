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
      ..strokeWidth = 12;

    // วาดเส้นสีเทาพื้นฐาน
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

    // กำหนด Gradient สีใหม่ตามเปอร์เซ็นต์
    paint.shader = const LinearGradient(
      colors: [
        Color.fromARGB(255, 56, 208, 190),
        Color.fromARGB(255, 155, 202, 146),
        Color.fromARGB(255, 255, 196, 102),
        Color.fromARGB(255, 255, 162, 135),
        Color.fromARGB(255, 255, 128, 169),
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
  const GaugeWidget({super.key});

  @override
  _GaugeWidgetState createState() => _GaugeWidgetState();
}

class _GaugeWidgetState extends State<GaugeWidget> {
  final double _percentage = 0.8;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          size: Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.width / 2),
          painter: RiskArc(percentage: _percentage),
        ),
        Positioned(
          bottom: 24,
          left: 0,
          right: 0,
          child: Column(
            children: [
              Text(
                "ภาวะเมตาบอลิกซินโดรมของคุณ",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.black),
              ),
              const SizedBox(height: 12),
              Text(
                "มีความเสี่ยงสูง",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Colors.black),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
