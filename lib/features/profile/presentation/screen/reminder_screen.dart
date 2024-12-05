import 'package:flutter/material.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/profile/presentation/widget/notification/noti_mission.dart';

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 36),
          child: Column(
            children: [
              // Mission section
              NotificationMission(),

              const SizedBox(height: 24),
              // Water section

              const SizedBox(height: 36),
              // Sleep section
              
            ],
          ),
        ),
      ),
    );
  }
}
