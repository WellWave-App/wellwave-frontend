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
    Function? onBackPressed, // Use this function to handle back step logic
    Function? action,
    IconData? actionIcon,
  }) : super(
          title: Text(
            title ?? '',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: textColor ?? Colors.black,
            ),
          ),
          titleSpacing: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: onLeading
              ? GestureDetector(
                  onTap: () {
                    if (onBackPressed != null) {
                      onBackPressed(); // Call the back step function
                    } else {
                      Navigator.of(context).pop(); // Fallback to pop
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
