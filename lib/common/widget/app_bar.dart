import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/constants/app_colors.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({
    super.key,
    super.backgroundColor,
    required String title,
    required BuildContext context,
    required bool onLeading,
    Color? textColor,
    Function? action,
    IconData? actionIcon,
  }) : super(
          title: Text(
            title,
            style: TextStyle(
              fontFamily: 'NotoSansThai',
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: textColor ?? AppColors.blackColor,
            ),
          ),
          titleSpacing: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: onLeading
              ? GestureDetector(
                  onTap: () => context.pop(),
                  child: Icon(
                    Icons.arrow_back,
                    size: 24,
                    color: textColor ?? AppColors.blackColor,
                  ),
                )
              : null,
          actions: [
            if (action != null)
              IconButton(
                onPressed: () => action,
                icon: actionIcon != null
                    ? Icon(actionIcon)
                    : const Icon(Icons.circle_outlined),
                color: textColor ?? AppColors.blackColor,
              ),
          ],
        );
}
