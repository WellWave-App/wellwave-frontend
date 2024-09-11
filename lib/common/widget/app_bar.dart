import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/constants/app_colors.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({
    super.key,
    super.backgroundColor,
    String? title,
    required BuildContext context,
    required bool onLeading,
    Color? textColor,
    Function? onBackPressed,
    Function? action,
    IconData? actionIcon,
  }) : super(
          title: Text(
            title ?? '',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.blackColor,
                ),
          ),
          titleSpacing: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: onLeading
              ? GestureDetector(
                  onTap: () {
                    if (onBackPressed != null) {
                      onBackPressed();
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new_sharp,
                    size: 14.9,
                    color: textColor ?? Colors.black,
                  ),
                )
              : const SizedBox.shrink(),
          actions: [
            if (action != null)
              IconButton(
                onPressed: () => action(),
                icon: actionIcon != null
                    ? Icon(actionIcon)
                    : const Icon(Icons.circle_outlined),
                color: textColor ?? Colors.black,
              ),
          ],
        );
}
