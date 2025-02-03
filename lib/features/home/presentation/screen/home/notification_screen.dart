import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wellwave_frontend/common/widget/app_bar.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_pages.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/home/data/models/notification.dart';
import 'package:wellwave_frontend/features/home/widget/mockup_data/notification_data.dart';
import 'package:wellwave_frontend/features/home/widget/notification_item.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Notifications> notificationlist = getMockNotificationData();
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        onLeading: true,
        title: 'แจ้งเตือน',
        backgroundColor: AppColors.transparentColor,
        onBackPressed: () {
          context.goNamed(AppPages.homePage);
        },
      ),
      body: notificationlist.isNotEmpty
          ? SingleChildScrollView(
              child: Column(
                children:
                    notificationlist.reversed.take(7).map((notifications) {
                  return NotificationItem(notifications: notifications);
                }).toList(),
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppImages.avatarNotiImage,
                    width: 128,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    AppStrings.noNotiText,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.darkgrayColor,
                        ),
                  ),
                ],
              ),
            ),
    );
  }
}
