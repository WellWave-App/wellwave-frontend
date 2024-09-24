import 'package:flutter/material.dart';
import '../../config/constants/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final BuildContext context;
  final bool onLeading;
  final Color? textColor;
  final Function? onBackPressed;
  final Function? action;
  final IconData? actionIcon;
  final String? rightText;
  final IconData? rightIcon;
  final Function? onRightPressed;
  final Color? backgroundColor;
  final Color? titleColor;
  final PreferredSizeWidget? bottom;

  const CustomAppBar(
      {super.key,
      this.title,
      required this.context,
      required this.onLeading,
      this.textColor,
      this.onBackPressed,
      this.action,
      this.actionIcon,
      this.rightText,
      this.rightIcon,
      this.onRightPressed,
      this.backgroundColor,
      this.titleColor,
      this.bottom});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      title: Text(
        title ?? '',
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: titleColor,
            ),
      ),
      titleSpacing: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading: onLeading
          ? GestureDetector(
              onTap: () {
                if (onBackPressed != null) {
                  onBackPressed!();
                } else {
                  Navigator.of(context).pop();
                }
              },
              child: Icon(
                Icons.arrow_back,
                size: 24,
                color: textColor ?? AppColors.blackColor,
              ),
            )
          : const SizedBox.shrink(),
      actions: [
        if (rightText != null)
          GestureDetector(
            onTap: () {
              if (onRightPressed != null) {
                onRightPressed!();
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text(
                rightText!,
                style: TextStyle(
                  color: textColor ?? AppColors.darkGrayColor,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
        if (rightIcon != null)
          IconButton(
            onPressed: () {
              if (onRightPressed != null) {
                onRightPressed!();
              }
            },
            icon: Icon(
              rightIcon,
              color: textColor ?? AppColors.darkGrayColor,
            ),
          ),
        if (action != null)
          IconButton(
            onPressed: () => action!(),
            icon: actionIcon != null
                ? Icon(actionIcon)
                : const Icon(Icons.circle_outlined),
            color: textColor ?? AppColors.darkGrayColor,
          ),
      ],
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
