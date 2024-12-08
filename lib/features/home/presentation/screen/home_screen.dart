// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/features/home/presentation/widget/showpoint.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    )
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
                    Container(
                      width: 24.0,
                      height: 24.0,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

