import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';

class DailyLogCard extends StatelessWidget {
  final String title;
  final String unitLabel;
  final int selectedLevel;
  final int maxLevel;
  final List<String> svgIcons;
  final Function() onTap;

  const DailyLogCard({
    Key? key,
    required this.title,
    required this.unitLabel,
    required this.selectedLevel,
    required this.maxLevel,
    required this.svgIcons,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        decoration: BoxDecoration(
          color: AppColors.tertiaryColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  '$selectedLevel $unitLabel',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.blackColor, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Center(
                    child: GestureDetector(
                      onTap: onTap,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          SvgPicture.asset(
                            svgIcons[
                                selectedLevel], // Display the SVG for the current level
                            width: 43,
                            height: 86,
                          ),
                          // Floating SVG at bottom-right corner
                          Positioned(
                            bottom: 0, // Align to the bottom
                            right: 0, // Align to the right
                            child: SvgPicture.asset(
                              AppImages.addIcon, // Path to the floating SVG
                              width: 32, // Desired size
                              height: 32,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
