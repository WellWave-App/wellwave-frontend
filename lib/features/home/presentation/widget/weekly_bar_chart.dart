import 'package:flutter/material.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';

class WeeklyBarChart extends StatelessWidget {
  const WeeklyBarChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(7, (index) {
        return Column(
          children: [
            Container(
              height: 30,
              width: 24,
              decoration: BoxDecoration(
                color: AppColors.gray50Color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 4),
            Text(
              ['จ', 'อ', 'พ', 'พฤ', 'ศ', 'ส', 'อา'][index],
              style: TextStyle(
                color: AppColors.grayColor,
                fontSize: 12,
              ),
            ),
          ],
        );
      }),
    );
  }
}
