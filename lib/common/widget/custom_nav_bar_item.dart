import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/config/constants/enums/navigation_enum.dart';

class CustomNavigationBarItem extends StatelessWidget {
  final int index;
  final int selectedIndex;
  final String iconAssetName;
  final String iconActiveAssetName;
  final double width;
  final double height;
  final bool showDot;
  final Function(int) onItemTapped;

  const CustomNavigationBarItem({
    super.key,
    required this.index,
    required this.selectedIndex,
    required this.iconAssetName,
    required this.iconActiveAssetName,
    required this.width,
    required this.height,
    required this.showDot,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            isSelected ? iconActiveAssetName : iconAssetName,
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
    );
  }
}


// class CustomNavigationBarItem extends StatelessWidget {
//   final int selectedIndex;
//   final Function(int) onItemTapped;

//   const CustomNavigationBarItem({
//     Key? key,
//     required this.selectedIndex,
//     required this.onItemTapped,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 10,
//             spreadRadius: 5,
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           _buildNavItem(0, AppImages.homeIcon, AppImages.homeIconActive, 24, 24, true),
//           _buildNavItem(1, AppImages.logIcon, AppImages.logIconActive, 24, 24, true),
//           _buildNavItem(2, AppImages.missionIcon, AppImages.missionIcon, 56, 56, false),
//           _buildNavItem(3, AppImages.friendIcon, AppImages.friendIconActive, 24, 24, true),
//           _buildNavItem(4, AppImages.articleIcon, AppImages.articleIconActive, 24, 24, true),
//         ],
//       ),
//     );
//   }

//   Widget _buildNavItem(int index, String icon, String iconActive, double width, double height, bool showDot) {
//     final isSelected = selectedIndex == index;
//     return GestureDetector(
//       onTap: () => onItemTapped(index),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           SvgPicture.asset(
//             isSelected ? iconActive : icon,
//             width: width,
//             height: height,
//           ),
//           if (isSelected && showDot)
//             Container(
//               margin: const EdgeInsets.only(top: 4),
//               width: 8,
//               height: 8,
//               decoration: const BoxDecoration(
//                 color: AppColors.primaryColor,
//                 shape: BoxShape.circle,
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
