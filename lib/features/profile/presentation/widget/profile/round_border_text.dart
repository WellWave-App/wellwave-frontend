import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';

class RoundedText extends StatelessWidget {
  final String text;
  final String svgPath;
  final bool isShowNavi;
  final String appPages;
  final double horizontal;
  final double vertical;
  final double iconSize;
  final bool isBold;
  final double radius;
  final Color backgroundColor;
  final Color textColor;
  final Color? iconColor;

  const RoundedText({
    Key? key,
    required this.text,
    required this.svgPath,
    this.isShowNavi = false,
    this.appPages = '',
    this.horizontal = 16,
    this.vertical = 4,
    this.iconSize = 24,
    this.isBold = false,
    this.radius = 8,
    this.backgroundColor = AppColors.whiteColor,
    this.iconColor,
    this.textColor = AppColors.blackColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              iconColor != null
                  ? SvgPicture.asset(
                      svgPath,
                      height: iconSize,
                      color: iconColor,
                    )
                  : SvgPicture.asset(
                      svgPath,
                      height: iconSize,
                    ),
              const SizedBox(width: 8),
              Text(
                text,
                style: isBold
                    ? Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold, color: textColor)
                    : Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: textColor),
              ),
            ],
          ),
          isShowNavi
              ? Row(
                  children: [
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: () {
                        context.goNamed(appPages);
                      },
                      child: Icon(
                        Icons.navigate_next_rounded,
                        color: AppColors.greyColor,
                        size: iconSize,
                      ),
                    ),
                  ],
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}
