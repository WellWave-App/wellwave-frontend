import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
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
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
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

class CustomAppBarWithStep extends AppBar {
  CustomAppBarWithStep({
    super.key,
    required BuildContext context,
    required bool onLeading,
    required int totalSteps,
    required int currentStep,
    Color? textColor,
    Color? bgColor,
    Function? onBackPressed,
    Function? action,
    IconData? actionIcon,
  }) : super(
          backgroundColor: Colors.transparent,
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
                    size: 16,
                    color: textColor ?? Colors.black,
                  ),
                )
              : const SizedBox(width: 48),
          actions: [
            if (action != null)
              IconButton(
                onPressed: () => action(),
                icon: Icon(actionIcon ?? Icons.circle_outlined),
                color: textColor ?? Colors.black,
              ),
            const SizedBox(width: 48),
          ],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                height: 20,
                child: StepProgressIndicator(
                  totalSteps: totalSteps,
                  currentStep: currentStep + 1,
                  size: 4,
                  padding: 0,
                  selectedColor: AppColors.primaryColor,
                  unselectedColor: AppColors.lightgrayColor,
                ),
              ),
            ],
          ),
        );
}
