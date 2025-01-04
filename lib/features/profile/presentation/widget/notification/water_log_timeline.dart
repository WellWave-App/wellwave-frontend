import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';

import '../../../../../config/constants/app_strings.dart';

class WaterLogTimeline extends StatefulWidget {
  const WaterLogTimeline({super.key});

  @override
  _WaterLogTimelineState createState() => _WaterLogTimelineState();
}

class _WaterLogTimelineState extends State<WaterLogTimeline> {
  List<Map<String, dynamic>> waterLogs = [
    {'glass': 'แก้วที่ 1', 'time': const TimeOfDay(hour: 9, minute: 0)},
    {'glass': 'แก้วที่ 2', 'time': const TimeOfDay(hour: 10, minute: 0)},
    {'glass': 'แก้วที่ 3', 'time': const TimeOfDay(hour: 11, minute: 0)},
    {'glass': 'แก้วที่ 4', 'time': const TimeOfDay(hour: 12, minute: 0)},
    {'glass': 'แก้วที่ 5', 'time': const TimeOfDay(hour: 13, minute: 0)},
    {'glass': 'แก้วที่ 6', 'time': const TimeOfDay(hour: 14, minute: 0)},
    {'glass': 'แก้วที่ 7', 'time': const TimeOfDay(hour: 15, minute: 0)},
    {'glass': 'แก้วที่ 8', 'time': const TimeOfDay(hour: 16, minute: 0)},
  ];

  Future<void> _adjustTime(int index) async {
    TimeOfDay selectedTime = waterLogs[index]['time'];

    DateTime? minDateTime;
    DateTime? maxDateTime;

    if (index > 0) {
      TimeOfDay prevTime = waterLogs[index - 1]['time'];
      minDateTime = DateTime(2025, 1, 1, prevTime.hour, prevTime.minute);
    }

    if (index < waterLogs.length - 1) {
      TimeOfDay nextTime = waterLogs[index + 1]['time'];
      maxDateTime = DateTime(2025, 1, 1, nextTime.hour, nextTime.minute);
    }

    await showModalBottomSheet<void>(
      backgroundColor: AppColors.whiteColor,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 3,
                    width: 140,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.only(bottom: 8),
                  ),
                  const SizedBox(height: 40),
                  Expanded(
                    child: CupertinoDatePicker(
                      initialDateTime: DateTime(
                        2025,
                        1,
                        1,
                        selectedTime.hour,
                        selectedTime.minute,
                      ),
                      mode: CupertinoDatePickerMode.time,
                      use24hFormat: true,
                      minimumDate: minDateTime,
                      maximumDate: maxDateTime,
                      onDateTimeChanged: (DateTime newDateTime) {
                        setModalState(() {
                          selectedTime = TimeOfDay(
                            hour: newDateTime.hour,
                            minute: newDateTime.minute,
                          );
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildCancleButton(),
                      const SizedBox(width: 10),
                      _buildConfirmButton(
                          () => _submitLogs(index, selectedTime)),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildCancleButton() {
    return Expanded(
      child: SizedBox(
        width: 170,
        height: 60,
        child: TextButton(
          onPressed: () => setState(() => Navigator.pop(context)),
          style: ButtonStyle(
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
                side: const BorderSide(color: AppColors.primaryColor, width: 1),
              ),
            ),
          ),
          child: Text(AppStrings.backText,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.primaryColor)),
        ),
      ),
    );
  }

  Widget _buildConfirmButton(VoidCallback onPressed) {
    return Expanded(
      child: SizedBox(
        width: 170,
        height: 60,
        child: TextButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor:
                WidgetStateProperty.all<Color>(AppColors.primaryColor),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
          ),
          child: Text(AppStrings.confirmText,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.white)),
        ),
      ),
    );
  }

  void _submitLogs(int index, TimeOfDay selectedTime) {
    // final logsBloc = BlocProvider.of<LogsBloc>(context);

    // String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

    // final logEvents = [
    //   SubmitLogEvent(
    //     logName: AppStrings.weightLogText,
    //     value: weight.toInt(),
    //     selectedDate: formattedDate,
    //   ),
    //   SubmitLogEvent(
    //     logName: AppStrings.waistLineLogText,
    //     value: waistLine.toInt(),
    //     selectedDate: formattedDate,
    //   ),
    //   if (isRecordHDL)
    //     SubmitLogEvent(
    //       logName: AppStrings.hdlLogText,
    //       value: hdl.toInt(),
    //       selectedDate: formattedDate,
    //     )
    // ];

    // for (var event in logEvents) {
    //   logsBloc.add(event);
    // }
    // ];
    setState(() {
      waterLogs[index]['time'] = selectedTime;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Dotted vertical line and logs
            Stack(
              children: [
                // Vertical dashed line
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Column(
                          children: [
                            // Dashed line before the first circle
                            const SizedBox(height: 40, child: DashedLine()),
                            ...List.generate(
                              waterLogs.length * 2 - 1,
                              (index) => index.isEven
                                  ? const CircleAvatar(
                                      radius: 4,
                                      backgroundColor: AppColors.primaryColor)
                                  : const SizedBox(
                                      height: 80, child: DashedLine()),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),

                // List items
                Padding(
                  padding: const EdgeInsets.only(left: 24, bottom: 24),
                  child: ListView.builder(
                    physics:
                        const NeverScrollableScrollPhysics(), // Disable inner scrolling
                    shrinkWrap:
                        true, // Let the ListView size itself to its content
                    itemCount: waterLogs.length,
                    itemBuilder: (context, index) {
                      final log = waterLogs[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: GestureDetector(
                          onTap: () => _adjustTime(index),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 24, horizontal: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: [
                                const SizedBox(width: 12),
                                SvgPicture.asset(
                                  AppImages
                                      .glassIcon, // Replace with your SVG path
                                  height: 24,
                                ),
                                const SizedBox(width: 12),
                                Text(log['glass'],
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            color: AppColors.darkGrayColor)),
                                const Spacer(),
                                Text(
                                    '${log['time'].hour.toString().padLeft(2, '0')}:${log['time'].minute.toString().padLeft(2, '0')}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            color: AppColors.blackColor)),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DashedLine extends StatelessWidget {
  const DashedLine({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const dashWidth = 4.0;
        const dashSpace = 4.0;
        final dashCount =
            (constraints.constrainHeight() / (dashWidth + dashSpace)).floor();
        return Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            dashCount,
            (index) => const SizedBox(
              width: 1,
              height: dashWidth,
              child: DecoratedBox(
                decoration: BoxDecoration(color: AppColors.primaryColor),
              ),
            ),
          ),
        );
      },
    );
  }
}
