import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';

import '../../../../../config/constants/app_strings.dart';
import '../../bloc/notification/noti_bloc.dart';

class WaterLogTimeline extends StatefulWidget {
  const WaterLogTimeline({super.key});

  @override
  _WaterLogTimelineState createState() => _WaterLogTimelineState();
}

class _WaterLogTimelineState extends State<WaterLogTimeline> {
  List<Map<String, dynamic>> waterLogs = [
    {'glassNumber': 1, 'time': null},
    {'glassNumber': 2, 'time': null},
    {'glassNumber': 3, 'time': null},
    {'glassNumber': 4, 'time': null},
    {'glassNumber': 5, 'time': null},
    {'glassNumber': 6, 'time': null},
    {'glassNumber': 7, 'time': null},
    {'glassNumber': 8, 'time': null},
  ];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<NotiBloc>(context).add(FetchDrinkPlanEvent());
  }

  Future<void> _adjustTime(int index) async {
    TimeOfDay? selectedTime = waterLogs[index]['time'];

    DateTime? minDateTime;
    DateTime? maxDateTime;

    if (index > 0) {
      TimeOfDay prevTime = waterLogs[index - 1]['time'];
      if (prevTime != null) {
        minDateTime = DateTime(2025, 1, 1, prevTime.hour, prevTime.minute);
      }
    }

    if (index < waterLogs.length - 1) {
      TimeOfDay? nextTime = waterLogs[index + 1]['time'];
      if (nextTime != null) {
        maxDateTime = DateTime(2025, 1, 1, nextTime.hour, nextTime.minute);
      }
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
                        selectedTime?.hour ?? 9,
                        selectedTime?.minute ?? 0,
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
                          () => _submitLogs(index, selectedTime!)),
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
    final int glassNumber = waterLogs[index]['glassNumber'];
    final String formattedTime = _formatTimeOfDay(selectedTime);

    context.read<NotiBloc>().add(CreateDrinkPlanEvent(
          uid: AppStrings.uid,
          glassNumber: glassNumber,
          notitime: formattedTime,
        ));

    setState(() {
      waterLogs[index]['time'] = selectedTime;
    });
    Navigator.pop(context);
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final formattedDateTime =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('HH:mm').format(formattedDateTime);
  }

  @override
  Widget build(BuildContext context) {
    context.read<NotiBloc>().add(
          FetchDrinkPlanEvent(),
        );
    return BlocListener<NotiBloc, NotiState>(
      listener: (context, state) {
        if (state is DrinkPlanState) {
          setState(() {
            BlocListener<NotiBloc, NotiState>(
              listener: (context, state) {
                if (state is DrinkPlanState) {
                  setState(() {
                    final glassIndex = waterLogs.indexWhere((entry) {
                      // Ensure type consistency during comparison
                      final entryGlassNumber = entry['glassNumber'];
                      if (entryGlassNumber is String) {
                        return int.tryParse(entryGlassNumber) ==
                            state.glassNumber;
                      } else if (entryGlassNumber is int) {
                        return entryGlassNumber == state.glassNumber;
                      }
                      return false;
                    });

                    if (glassIndex != -1) {
                      waterLogs[glassIndex]['time'] = state.notitime.isNotEmpty
                          ? TimeOfDay.fromDateTime(
                              DateFormat("HH:mm").parse(state.notitime))
                          : null;
                    }
                  });
                }
              },
            );
          });
        }
      },
      child: BlocBuilder<NotiBloc, NotiState>(
        builder: (context, state) {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return Column(
                                children: [
                                  const SizedBox(
                                      height: 40, child: DashedLine()),
                                  ...List.generate(
                                    waterLogs.length * 2 - 1,
                                    (index) => index.isEven
                                        ? const CircleAvatar(
                                            radius: 4,
                                            backgroundColor:
                                                AppColors.primaryColor)
                                        : const SizedBox(
                                            height: 80, child: DashedLine()),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 24, bottom: 24),
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: waterLogs.length,
                          itemBuilder: (context, index) {
                            final log = waterLogs[index];
                            final isEnabled = index == 0 ||
                                waterLogs[index - 1]['time'] != null;

                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: GestureDetector(
                                onTap:
                                    isEnabled ? () => _adjustTime(index) : null,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 24, horizontal: 12),
                                  decoration: BoxDecoration(
                                    color: isEnabled
                                        ? Colors.white
                                        : Colors.grey[300],
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 12),
                                      SvgPicture.asset(
                                        AppImages.glassIcon,
                                        height: 24,
                                        color: isEnabled ? null : Colors.grey,
                                      ),
                                      const SizedBox(width: 12),
                                      Text('แก้วที่ ${log['glassNumber']}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  color: isEnabled
                                                      ? AppColors.darkGrayColor
                                                      : Colors.grey)),
                                      const Spacer(),
                                      Text(
                                        log['time'] != null
                                            ? '${log['time'].hour.toString().padLeft(2, '0')}:${log['time'].minute.toString().padLeft(2, '0')}'
                                            : '--:--',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                                color: isEnabled
                                                    ? AppColors.blackColor
                                                    : Colors.grey),
                                      ),
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
        },
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
