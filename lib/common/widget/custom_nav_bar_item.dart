import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import '../../config/constants/app_images.dart';

class CustomNavigationBarItem extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomNavigationBarItem({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        _buildNavItem(
            0, AppImages.homeIcon, AppImages.homeIconActive, 24, 24, true),
        _buildNavItem(
            1, AppImages.logIcon, AppImages.logIconActive, 24, 24, true),
        _buildNavItem(
            2, AppImages.missionIcon, AppImages.missionIcon, 56, 56, false),
        _buildNavItem(
            3, AppImages.friendIcon, AppImages.friendIconActive, 24, 24, true),
        _buildNavItem(4, AppImages.articleIcon, AppImages.articleIconActive, 24,
            24, true),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: Colors.grey,
      onTap: onItemTapped,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    );
  }

  BottomNavigationBarItem _buildNavItem(int index, String icon,
      String iconActive, double width, double height, bool showDot) {
    final isSelected = selectedIndex == index;
    return BottomNavigationBarItem(
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            isSelected ? iconActive : icon,
            width: width,
            height: height,
          ),
          if (isSelected && showDot)
            Container(
              margin: const EdgeInsets.only(top: 4),
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
      label: AppStrings.emptyText,
    );
  }
}
