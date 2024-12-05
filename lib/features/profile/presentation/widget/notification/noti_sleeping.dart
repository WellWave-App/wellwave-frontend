import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';

class NotificationSleeping extends StatefulWidget {
  const NotificationSleeping({super.key});

  @override
  State<NotificationSleeping> createState() => _NotificationSleepingState();
}

class _NotificationSleepingState extends State<NotificationSleeping> {
  bool _isSwitched = false;
  
  @override
  Widget build(BuildContext context) {
    return Column(
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 16),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
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
                          activeColor: Colors.white, // Circle color (active)
                          activeTrackColor:
                              const Color(0xFF34C759), // Track color (active)
                          inactiveThumbColor:
                              AppColors.whiteColor, // Circle color (inactive)
                          inactiveTrackColor:
                              AppColors.darkGrayColor, // Track color (inactive)
                        ),
                      ],
                    ),
                  ),
                ],
              );
  }
}