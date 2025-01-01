import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';

class UserInfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    AppImages.avatarDefaultIcon,
                    width: 64.0,
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ปลายฟ้า',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            'อัพเดท:',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          SizedBox(width: 4),
                          Text(
                            '13 สิงหาคม 2567',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  SvgPicture.asset(AppImages.waveImage),
                ],
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        'ก้าวเดิน',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.darkgrayColor,
                            ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '6895 ก้าว',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),
                  Container(
                    height: 40,
                    width: 1,
                    color: Colors.grey[300],
                  ),
                  Column(
                    children: [
                      Text(
                        'การนอน',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.darkgrayColor,
                            ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '7 ชม.',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
