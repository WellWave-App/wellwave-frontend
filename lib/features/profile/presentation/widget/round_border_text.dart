import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';

class RoundedText extends StatelessWidget {
  final String text;
  final String svgPath;
  final bool isShowNavi;
  final String appPages;

  const RoundedText({
    Key? key,
    required this.text,
    required this.svgPath,
    this.isShowNavi = false,
    this.appPages = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.whiteColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            svgPath,
            height: 24,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(),
          ),
          isShowNavi
              ? Row(
                  children: [
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: () {
                        context.goNamed(appPages);
                      },
                      child: const Icon(
                        Icons.navigate_next_rounded,
                        color: AppColors.greyColor,
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
