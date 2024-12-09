import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/enums/greeting_message.dart';
import 'package:wellwave_frontend/features/home/presentation/widget/top_of_screen.dart';

class GreetingWidget extends StatelessWidget {
  const GreetingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final DailyMessage dailyMessage = DailyMessage();

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          const SizedBox(height: 16),
          TopOfScreen(),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${GreetingTimeText.getGreetingMessage()}, แจน',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppColors.whiteColor,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    dailyMessage.getMessage(),
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppColors.whiteColor,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '10',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: AppColors.whiteColor,
                            ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'วันต่อเนื่อง',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.whiteColor,
                            ),
                      ),
                      const SizedBox(width: 4),
                      SvgPicture.asset(
                        AppImages.fireIcon,
                        height: 16,
                      ),
                    ],
                  ),
                ],
              ),
              // Avatar image
              SvgPicture.asset(
                AppImages.avatarImage,
                height: 120,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
