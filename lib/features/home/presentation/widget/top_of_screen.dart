import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/features/home/presentation/screen/friend_screen.dart';
import 'package:wellwave_frontend/features/home/presentation/widget/health_data/showpoint.dart';

class TopOfScreen extends StatelessWidget {
  const TopOfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CoinDisplay(
              pointText: '150',
              icon: AppImages.expIcon,
            ),
            const SizedBox(
              width: 16,
            ),
            CoinDisplay(
              pointText: '150',
              icon: AppImages.gemIcon,
            ),
          ],
        ),
        Row(
          children: [
            SvgPicture.asset(
              AppImages.notiIcon,
              height: 32.0,
            ),
            const SizedBox(
              width: 16,
            ),
            GestureDetector(
              onTap: () {
                // โยงไปหน้า profile
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FriendScreen()),
                );
              },
              child: SvgPicture.asset(
                AppImages.avatarDefaultIcon,
                height: 32.0,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
