import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_pages.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';

import '../../../../../config/constants/app_images.dart';
import 'noti_mission_widget.dart';

class NotificationMission extends StatefulWidget {
  const NotificationMission({super.key});

  @override
  State<NotificationMission> createState() => _NotificationMissionState();
}

class _NotificationMissionState extends State<NotificationMission> {
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
                  context.goNamed(AppPages.logHistoryName);
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.primaryColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                ),
                child: Text(AppStrings.selectAllText,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: AppColors.secondaryDarkColor)),
              ),
            )
          ],
        ),
        const SizedBox(height: 16),
        const Column(
          children: [
            NotiMissionWidget(
              time: '01:05',
              day: 'Everyday',
              description: 'ชวนปั่น 100 km ใน 1 เดือน',
            ),
            NotiMissionWidget(
              time: '01:05',
              day: 'Everyday',
              description: 'ชวนปั่น 100 km ใน 1 เดือน',
            ),
            NotiMissionWidget(
              time: '01:05',
              day: 'Everyday',
              description: 'ชวนปั่น 100 km ใน 1 เดือน',
            ),
          ],
        )
      ],
    );
  }
}
