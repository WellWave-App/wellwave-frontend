import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'notification_service.dart';

import '../bloc/noti_bloc.dart';
import '../../../profile/presentation/widget/cancle_confirm_button.dart';

void scheduleBedtimeNotifications(Map<String, dynamic> bedtimeSettings) {
  String bedtimeTime = bedtimeSettings['BEDTIME'];
  List<String> timeParts = bedtimeTime.split(':');
  int hour = int.parse(timeParts[0]);
  int minute = int.parse(timeParts[1]);

  Map<String, bool> weekdays = bedtimeSettings['WEEKDAYS'];

  DateTime now = DateTime.now();

  weekdays.forEach((day, isEnabled) {
    if (isEnabled) {
      // Find the next occurrence of this day
      DateTime nextDay = _findNextDay(day, now);

      // Set the time for the notification
      DateTime scheduledTime = DateTime(
        nextDay.year,
        nextDay.month,
        nextDay.day,
        hour,
        minute,
      );

      NotificationService().scheduleDailyNotification(scheduledTime);
    }
  });
}

DateTime _findNextDay(String day, DateTime now) {
  // Map days to their respective indices (Sunday = 0, Monday = 1, etc.)
  Map<String, int> dayIndices = {
    'Sunday': 7,
    'Monday': 1,
    'Tuesday': 2,
    'Wednesday': 3,
    'Thursday': 4,
    'Friday': 5,
    'Saturday': 6,
  };

  int currentDayIndex = now.weekday;
  int targetDayIndex = dayIndices[day]!;

  int daysToAdd = (targetDayIndex - currentDayIndex + 7) % 7;
  if (daysToAdd == 0) {
    daysToAdd = 7;
  }

  return now.add(Duration(days: daysToAdd));
}

class NotificationSleeping extends StatefulWidget {
  const NotificationSleeping({super.key});

  @override
  State<NotificationSleeping> createState() => _NotificationSleepingState();
}

class _NotificationSleepingState extends State<NotificationSleeping> {
  bool _isSwitched = false;
  DateTime time = DateTime.now();
  List<bool> selectedDays = List.filled(7, false);
  String day = '';

  @override
  void initState() {
    super.initState();
    BlocProvider.of<NotiBloc>(context).add(FetchBedtimeEvent());
  }

  void _toggleSwitch(bool value) {
    if (_isSwitched != value) {
      setState(() {
        _isSwitched = value;
      });

      context
          .read<NotiBloc>()
          .add(UpdateBedtimeEvent(uid: AppStrings.uid, isActive: _isSwitched));
    }
  }

  void updateSelectedDaysText() {
    List<String> days = ['อา', 'จ', 'อ', 'พ', 'พฤ', 'ศ', 'ส'];
    List<int> selectedIndices = selectedDays
        .asMap()
        .entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    if (selectedIndices.isEmpty) {
      setState(() => day = ''); // No days selected
    } else {
      // Check if the selected days are consecutive, accounting for wrapping around
      bool isConsecutive = true;
      for (int i = 0; i < selectedIndices.length - 1; i++) {
        if ((selectedIndices[i] + 1) % 7 != selectedIndices[i + 1]) {
          isConsecutive = false;
          break;
        }
      }

      if (isConsecutive && selectedIndices.length > 1) {
        int firstIndex = selectedIndices.first;
        int lastIndex = selectedIndices.last;
        setState(() => day = '${days[firstIndex]} ถึง ${days[lastIndex]}');
      } else {
        setState(() => day = selectedIndices
            .map((index) => days[index])
            .join(', ')); // Non-consecutive days
      }
    }
  }

  void _submitLogs() {
    updateSelectedDaysText();
    String formattedTime = DateFormat('HH:mm').format(time);

    List<String> days = [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday'
    ];

    Map<String, bool> weekdays = {
      for (int i = 0; i < selectedDays.length; i++) days[i]: selectedDays[i],
    };

    // Create bedtime settings
    Map<String, dynamic> bedtimeSettings = {
      "UID": AppStrings.uid,
      "NOTIFICATION_TYPE": "BEDTIME",
      "BEDTIME": formattedTime,
      "WEEKDAYS": weekdays,
    };

    // Schedule notifications
    scheduleBedtimeNotifications(bedtimeSettings);

    // Send the event to the Bloc
    context.read<NotiBloc>().add(CreateBedtimeEvent(
          uid: AppStrings.uid,
          isActive: true,
          bedtime: formattedTime,
          weekdays: weekdays,
        ));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // context.read<NotiBloc>().add(
    //       FetchBedtimeEvent(),
    //     );
    return BlocListener<NotiBloc, NotiState>(
      listener: (context, state) {
        if (state is BedtimeState) {
          setState(() {
            _isSwitched = state.isActive;
            if (state.bedtime.isNotEmpty) {
              time = DateFormat("HH:mm").parse(state.bedtime);
            }

            // Update selectedDays based on weekdays fetched
            List<String> days = [
              'Sunday',
              'Monday',
              'Tuesday',
              'Wednesday',
              'Thursday',
              'Friday',
              'Saturday'
            ];
            for (int i = 0; i < days.length; i++) {
              selectedDays[i] = state.weekdays[days[i]] ?? false;
            }
            updateSelectedDaysText(); // Ensure `day` is updated
          });
        }
      },
      child: BlocBuilder<NotiBloc, NotiState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(AppImages.sleepingIcon, height: 21),
                    const SizedBox(width: 8),
                    Text(
                      AppStrings.sleepingText,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _isSwitched
                          ? GestureDetector(
                              onTap: () => _showTimePickerModal(context),
                              child: Row(
                                children: [
                                  Text(
                                    '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    day,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            color: AppColors.darkGrayColor),
                                  ),
                                ],
                              ),
                            )
                          : Text(
                              AppStrings.setTimeText,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                      Switch(
                        value: _isSwitched,
                        onChanged: (value) {
                          _toggleSwitch(value);
                        },
                        activeColor: Colors.white,
                        activeTrackColor: const Color(0xFF34C759),
                        inactiveThumbColor: AppColors.whiteColor,
                        inactiveTrackColor: AppColors.darkGrayColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showTimePickerModal(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: AppColors.whiteColor,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Container(
                      height: 3,
                      width: 140,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.only(bottom: 8),
                    ),
                  ),
                  const SizedBox(height: 45),
                  _buildDaySelector(setModalState),
                  const SizedBox(height: 36),
                  SizedBox(height: 120, child: _buildTimePicker(setModalState)),
                  const SizedBox(height: 36),
                  ConfirmCancelButtons(
                    onConfirm: _submitLogs,
                    onCancel: () => setState(() => Navigator.pop(context)),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDaySelector(StateSetter setModalState) {
    List<String> days = ['อา', 'จ', 'อ', 'พ', 'พฤ', 'ศ', 'ส'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.dayText,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(7, (index) {
            return GestureDetector(
              onTap: () {
                setModalState(() {
                  selectedDays[index] = !selectedDays[index];
                });
              },
              child: Container(
                width: 44,
                height: 52,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: selectedDays[index]
                      ? AppColors.primaryColor
                      : AppColors.whiteColor,
                  border: Border.all(color: AppColors.primaryColor),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    days[index],
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: selectedDays[index]
                              ? Colors.white
                              : AppColors.primaryColor,
                        ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildTimePicker(StateSetter setModalState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.timeText,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Expanded(
          child: CupertinoDatePicker(
            initialDateTime: time,
            mode: CupertinoDatePickerMode.time,
            use24hFormat: true,
            onDateTimeChanged: (DateTime newTime) {
              setModalState(() => time = newTime);
            },
          ),
        )
      ],
    );
  }
}
