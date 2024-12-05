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
