import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wellwave_frontend/common/widget/app_bar.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';

class MissionRecordPage extends StatefulWidget {
  final String title;
  final int hid;

  const MissionRecordPage({
    super.key,
    required this.title,
    required this.hid,
  });

  @override
  _MissionRecordPageState createState() => _MissionRecordPageState();
}

class _MissionRecordPageState extends State<MissionRecordPage> {
  // Add timer controller
  StreamController<int>? _timerController;
  bool _isRunning = true;
  int _lastElapsedSeconds = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timerController = StreamController<int>();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isRunning && !_timerController!.isClosed) {
        _lastElapsedSeconds++;
        _timerController!.add(_lastElapsedSeconds);
      }
    });
  }

  void _stopTimer() {
    setState(() {
      _isRunning = false;
    });
  }

  void _resumeTimer() {
    setState(() {
      _isRunning = true;
    });
  }

  void _completeTimer() {
    // TODO: Add API call to save progress
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _timerController?.close();
    super.dispose();
  }

  String formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int secs = seconds % 60;
    return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}";
  }

  // Update the calculateProgress method
  double calculateProgress(int elapsedSeconds) {
    // Calculate total progress including all cycles
    double totalProgress = elapsedSeconds / 60.0;
    return totalProgress;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        title: '',
        backgroundColor: AppColors.whiteColor,
        titleColor: AppColors.blackColor,
        textColor: AppColors.blackColor,
        onLeading: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              '${widget.title}',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: StreamBuilder<int>(
              stream: _timerController?.stream,
              builder: (context, snapshot) {
                int elapsedSeconds = snapshot.data ?? 0;
                double totalProgress = calculateProgress(elapsedSeconds);
                int completedCycles = elapsedSeconds ~/ 60;
                String timeString = formatTime(elapsedSeconds);

                List<Color> colors = [
                  AppColors.mintColor,
                  AppColors.skyBlueColor,
                ];

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: completedCycles >= 1
                                  ? AppColors.mintColor.withOpacity(0.1)
                                  : AppColors.lightgrayColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  completedCycles >= 1
                                      ? Icons.check_circle_rounded
                                      : Icons.local_fire_department_rounded,
                                  color: completedCycles >= 1
                                      ? AppColors.mintColor
                                      : AppColors.redLevelColor,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  completedCycles >= 1
                                      ? 'ครบเป้าหมายแล้ว!'
                                      : 'เป้าหมาย: 1 รอบ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: completedCycles >= 1
                                            ? AppColors.mintColor
                                            : AppColors.darkGrayColor,
                                        fontWeight: completedCycles >= 1
                                            ? FontWeight.w600
                                            : FontWeight.w500,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 250,
                          width: 250,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.lightgrayColor,
                          ),
                        ),
                        Container(
                          width: 180,
                          height: 180,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 0,
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'ระยะเวลา',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: AppColors.blackColor,
                                      ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  timeString,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge
                                      ?.copyWith(
                                        color: AppColors.blackColor,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 250,
                          width: 250,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                          ),
                          child: TweenAnimationBuilder<double>(
                            tween: Tween<double>(begin: 0, end: totalProgress),
                            duration: const Duration(milliseconds: 500),
                            builder: (context, value, _) {
                              return CustomPaint(
                                painter: CircularProgressPainter(
                                  progress: value,
                                  strokeWidth: 36.0,
                                  color:
                                      colors[completedCycles % colors.length],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_isRunning) {
                          _stopTimer();
                        } else {
                          _resumeTimer();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.whiteColor,
                        foregroundColor: AppColors.whiteColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        elevation: 0, // Remove default elevation
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(
                            color: Colors.black.withOpacity(0.1),
                            width: 1,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            _isRunning
                                ? AppImages.stopMissionRecordIcon
                                : AppImages.resumeMissionRecordIcon,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _isRunning ? 'หยุดพัก' : 'ทำต่อ',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppColors.blackColor,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8), // Reduced from 16 to 8
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 0,
                          blurRadius: 2,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: _completeTimer,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.whiteColor,
                        foregroundColor: AppColors.whiteColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        elevation: 0, // Remove default elevation
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(
                            color: Colors.black.withOpacity(0.1),
                            width: 1,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppImages.finishMissionRecordIcon,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'เสร็จสิ้น',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppColors.blackColor,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CircularProgressPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color color;

  CircularProgressPainter({
    required this.progress,
    required this.strokeWidth,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    int fullCircles = progress.floor();
    double remainingProgress = progress - fullCircles;

    final gradient = SweepGradient(
      colors: [
        const Color.fromARGB(255, 56, 77, 207),
        const Color.fromARGB(255, 56, 196, 194),
        const Color.fromARGB(255, 56, 77, 207),
        const Color.fromARGB(255, 56, 196, 194),
        const Color.fromARGB(255, 56, 77, 207),
      ],
      stops: const [
        0.0,
        0.25,
        0.5,
        0.75,
        1.0,
      ],
      transform: GradientRotation(-1.5708),
      tileMode: TileMode.mirror,
    );

    // Draw completed circles first
    for (int i = 0; i < fullCircles; i++) {
      canvas.drawCircle(
        center,
        radius,
        Paint()
          ..shader = gradient.createShader(
            Rect.fromCircle(center: center, radius: radius),
          )
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round,
      );
    }

    // Draw current progress arc
    if (remainingProgress > 0) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -1.5708,
        remainingProgress * 2 * pi,
        false,
        Paint()
          ..shader = gradient.createShader(
            Rect.fromCircle(center: center, radius: radius),
          )
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round,
      );
    }

    // Calculate total angle for end point position
    final totalAngle = (remainingProgress * 2 * pi) + (fullCircles * 2 * pi);

    // Calculate end point for current position
    final endPoint = Offset(
      center.dx + radius * cos(-1.5708 + totalAngle),
      center.dy + radius * sin(-1.5708 + totalAngle),
    );

    // Increase dot size
    final dotSize = strokeWidth * 0.6; // Increased from 0.5

    // Draw shadow for yellow circle
    canvas.drawCircle(
      endPoint,
      dotSize,
      Paint()
        ..color = Colors.black.withOpacity(0.3)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3)
        ..style = PaintingStyle.fill,
    );

    // Draw yellow circle with gradient
    canvas.drawCircle(
      endPoint,
      dotSize,
      Paint()
        ..color = const Color.fromARGB(255, 56, 77, 207)
        ..shader = RadialGradient(
          colors: [
            const Color.fromARGB(255, 28, 45, 160),
            const Color.fromARGB(255, 28, 45, 160),
          ],
          stops: const [0.5, 1.0],
        ).createShader(
          Rect.fromCircle(center: endPoint, radius: dotSize),
        )
        ..style = PaintingStyle.fill,
    );

    canvas.save();
    canvas.translate(endPoint.dx, endPoint.dy);

    final icon = Icons.local_fire_department;
    final textPainter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          fontSize: dotSize * 1.5, // Increased from 0.8
          fontFamily: icon.fontFamily,
          color: Colors.white,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        -textPainter.width / 2,
        -textPainter.height / 2,
      ),
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(CircularProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
