import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wellwave_frontend/common/widget/app_bar.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';

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
  final Stream<int> timerStream = (() {
    return Stream<int>.periodic(const Duration(seconds: 1), (count) {
      return count;
    });
  })();

  String formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int secs = seconds % 60;
    return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}";
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
          Expanded(
            child: StreamBuilder<int>(
              stream: timerStream,
              builder: (context, snapshot) {
                int elapsedSeconds = snapshot.data ?? 0;
                double percent = (elapsedSeconds % 60) / 60;
                String timeString = formatTime(elapsedSeconds);
                int cycle = elapsedSeconds ~/ 60;

                List<Color> colors = [
                  AppColors.mintColor,
                  AppColors.skyBlueColor,
                ];

                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 250,
                      width: 250,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.grayProgressColor,
                      ),
                      child: CircularProgressIndicator(
                        value: 1.0,
                        strokeCap: StrokeCap.round,
                        strokeWidth: 24.0,
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    Container(
                      height: 250,
                      width: 250,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                      ),
                      child: CircularProgressIndicator(
                        value: percent,
                        strokeWidth: 24.0,
                        strokeCap: StrokeCap.round,
                        valueColor: AlwaysStoppedAnimation(
                            colors[cycle % colors.length]),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'ระยะเวลา',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            timeString,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
