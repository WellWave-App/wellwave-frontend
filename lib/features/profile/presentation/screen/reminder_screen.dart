import 'package:flutter/material.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/profile/presentation/widget/notification/noti_drinking.dart';
import 'package:wellwave_frontend/features/profile/presentation/widget/notification/noti_mission.dart';
import 'package:wellwave_frontend/features/profile/presentation/widget/notification/noti_sleeping.dart';

import '../../../../common/widget/app_bar.dart';
import '../../../../config/constants/app_colors.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
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

  void _submitLogs() {
    // String formattedtimeStarttime = DateFormat('HH:mm').format(startTime);
    // String formattedtimeEndtime = DateFormat('HH:mm').format(endTime);
    // int intervalMinute = (double.parse(hourSet) * 60).toInt();

    // context.read<NotiBloc>().add(CreateDrinkRangeEvent(
    //       uid: AppStrings.uid,
    //       startTime: formattedtimeStarttime,
    //       endTime: formattedtimeEndtime,
    //       intervalMinute: intervalMinute,
    //     ));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(
          title: AppStrings.alertText, context: context, onLeading: true),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 36),
          child: Column(
            children: [
              NotificationMission(),
              SizedBox(height: 24),
              NotificationDrinking(),
              SizedBox(height: 36),
              NotificationSleeping()
            ],
          ),
        ),
      ),
    );
  }
}
