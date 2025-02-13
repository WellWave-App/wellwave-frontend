import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_pages.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';

import '../../../../config/constants/app_images.dart';
import '../../../profile/presentation/widget/cancle_confirm_button.dart';
import '../bloc/noti_bloc.dart';
import 'noti_mission_widget.dart';

class NotificationMission extends StatefulWidget {
  const NotificationMission({super.key});

  @override
  State<NotificationMission> createState() => _NotificationMissionState();
}

class _NotificationMissionState extends State<NotificationMission> {
  bool _isSwitched = false;
  DateTime time = DateTime.now();
  List<bool> selectedDays = List.filled(7, false);
  String day = '';

  @override
  void initState() {
    super.initState();
    debugPrint('Initializing NotificationMission widget');
    BlocProvider.of<NotiBloc>(context).add(FetchMissionEvent());
  }

  // void _toggleSwitch(bool value) {
  //   if (_isSwitched != value) {
  //     setState(() {
  //       _isSwitched = value;
  //     });

  //     context
  //         .read<NotiBloc>()
  //         .add(UpdateBedtimeEvent(uid: AppStrings.uid, isActive: _isSwitched));
  //   }
  // }

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
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(AppImages.fireIcon, height: 21),
                const SizedBox(width: 8),
                Text(
                  AppStrings.taskText,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 28,
              child: TextButton(
                onPressed: () {
                  context.read<NotiBloc>().add(ToggleAllSwitchesEvent());
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.primaryColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                ),
                child: Text(
                  AppStrings.selectAllText,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: AppColors.secondaryDarkColor),
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 16),
        BlocBuilder<NotiBloc, NotiState>(
          builder: (context, state) {
            debugPrint('Current state in builder: ${state.runtimeType}');
            if (state is NotiLoadedState && state.missionState != null) {
              debugPrint(
                  'Building UI with ${state.missionState!.missions.length} missions');

              return Column(
                children: state.missionState!.missions.map((mission) {
                  final selectedDays = mission.weekdaysNoti.entries
                      .where((entry) => entry.value)
                      .map((entry) => entry.key)
                      .toList();

                  final formattedDays = selectedDays.isEmpty
                      ? "No notification set"
                      : selectedDays.join(", ");

                  return NotiMissionWidget(
                    time: "08:00", // Adjust time as needed
                    day: formattedDays,
                    title: mission.title,
                    isSwitched:
                        mission.isNotificationEnabled, // Pass the boolean value
                  );
                }).toList(),
              );
            } else if (state is NotiError) {
              return Center(
                child: Text("Error: ${(state).message}"),
              );
            } else {
              debugPrint('Showing loading indicator');
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ],
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
