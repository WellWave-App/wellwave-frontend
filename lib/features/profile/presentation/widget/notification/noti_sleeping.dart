import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';

import '../../bloc/notification/noti_bloc.dart';

class NotificationSleeping extends StatefulWidget {
  const NotificationSleeping({super.key});

  @override
  State<NotificationSleeping> createState() => _NotificationSleepingState();
}

class _NotificationSleepingState extends State<NotificationSleeping> {
  bool _isSwitched = false;
  DateTime time = DateTime.now();
  List<bool> selectedDays = List.filled(7, false);
  String day = 'ทุกวัน';

  void updateSelectedDaysText() {
    List<String> days = ['อา', 'จ', 'อ', 'พ', 'พฤ', 'ศ', 'ส'];
    List<int> selectedIndices = [];

    // Collect indices of selected days
    for (int i = 0; i < selectedDays.length; i++) {
      if (selectedDays[i]) {
        selectedIndices.add(i);
      }
    }

    // Determine the text to display
    if (selectedIndices.isEmpty) {
      setState(() {
        day = ''; // No days selected
      });
    } else {
      // Check if the selected days are consecutive, including wrapping (e.g., 5, 6, 0)
      bool isConsecutive = true;
      for (int i = 1; i < selectedIndices.length; i++) {
        int current = selectedIndices[i];
        int previous = selectedIndices[i - 1];

        if (current != (previous + 1) % 7) {
          isConsecutive = false;
          break;
        }
      }

      if (isConsecutive && selectedIndices.length > 1) {
        // If days are consecutive, display the range
        int firstIndex = selectedIndices.first;
        int lastIndex = selectedIndices.last;

        setState(() {
          day = '${days[firstIndex]} ถึง ${days[lastIndex]}';
        });
      } else {
        // If days are not consecutive, list them individually
        List<String> selectedDaysText =
            selectedIndices.map((index) => days[index]).toList();

        setState(() {
          day = selectedDaysText.join(', ');
        });
      }
    }

    debugPrint('Updated day text: $day');
  }

  Widget _buildConfirmButton() {
    return Expanded(
      child: SizedBox(
        width: 170,
        height: 60,
        child: TextButton(
          onPressed: _submitLogs,
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

  Widget _buildCancelButton() {
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

  void _submitLogs() {
    debugPrint('Submit logs called');
    updateSelectedDaysText();
    String formattedTime = DateFormat('HH:mm').format(time);

    final bloc = BlocProvider.of<NotiBloc>(context);

    bloc.add(CreateBedtimeEvent(
      uid: 5,
      isActive: true,
      bedtime: formattedTime,
    ));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
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
              )
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _isSwitched
                    ? Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              await showModalBottomSheet(
                                backgroundColor: AppColors.whiteColor,
                                context: context,
                                builder: (context) {
                                  return StatefulBuilder(
                                    builder: (context, setModalState) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 24, horizontal: 20),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Center(
                                              child: Container(
                                                height: 3,
                                                width: 140,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                margin: const EdgeInsets.only(
                                                    bottom: 8),
                                              ),
                                            ),
                                            const SizedBox(height: 45),
                                            Text(AppStrings.dayText,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                            const SizedBox(height: 16),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children:
                                                  List.generate(7, (index) {
                                                String day = [
                                                  'อา',
                                                  'จ',
                                                  'อ',
                                                  'พ',
                                                  'พฤ',
                                                  'ศ',
                                                  'ส'
                                                ][index];
                                                return GestureDetector(
                                                  onTap: () {
                                                    setModalState(() {
                                                      selectedDays[index] =
                                                          !selectedDays[index];
                                                    });
                                                  },
                                                  child: Container(
                                                    width: 44,
                                                    height: 52,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 12,
                                                        vertical: 8),
                                                    decoration: BoxDecoration(
                                                      color: selectedDays[index]
                                                          ? AppColors
                                                              .primaryColor
                                                          : AppColors
                                                              .whiteColor,
                                                      border: Border.all(
                                                          color: AppColors
                                                              .primaryColor),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        day,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall
                                                            ?.copyWith(
                                                              color: selectedDays[
                                                                      index]
                                                                  ? Colors.white
                                                                  : AppColors
                                                                      .primaryColor,
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                                            ),
                                            const SizedBox(height: 36),
                                            Text('เวลา',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                            const SizedBox(height: 16),
                                            Expanded(
                                              child: CupertinoDatePicker(
                                                initialDateTime: time,
                                                mode: CupertinoDatePickerMode
                                                    .time,
                                                use24hFormat: true,
                                                onDateTimeChanged:
                                                    (DateTime newTime) {
                                                  setModalState(
                                                      () => time = newTime);
                                                },
                                              ),
                                            ),
                                            const SizedBox(height: 36),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                _buildCancelButton(),
                                                const SizedBox(width: 10),
                                                _buildConfirmButton()
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            },
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
                          ),
                        ],
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
                    setState(() {
                      _isSwitched = value;
                    });
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
  }
}
