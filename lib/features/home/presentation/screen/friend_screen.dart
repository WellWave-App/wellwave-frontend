import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';

class FriendScreen extends StatelessWidget {
  const FriendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // UserInfoCard(),
            // const SizedBox(
            //   height: 16,
            // ),
            // UserInfoCard(),
            SvgPicture.asset(
              AppImages.fireIcon,
              width: 128,
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              'ยังไม่มีข้อมูล เพิ่มเพื่อนเลย!',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.darkgrayColor,
                  ),
            ),
          ],
        ),
      ),
    ));
  }
}
