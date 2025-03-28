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
    Widget? actionIcon,
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
                  onTap: () => context.pop(),
                  child: Icon(
                    Icons.arrow_back,
                    size: 24,
                    color: textColor ?? AppColors.blackColor,
                  ),
                )
              : null,
          actions: [
            if (action != null && actionIcon != null)
              GestureDetector(
                onTap: () => action(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: actionIcon,
                ),
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
    bool showStepIndicator = true,
    String? titleText,
    Color? textColor,
    Color? bgColor,
    Function? onBackPressed,
    Function? action,
    IconData? actionIcon,
    Widget? additionalIcon,
    Function? additionalAction,
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
                    Icons.arrow_back,
                    size: 24,
                    color: textColor ?? Colors.black,
                  ),
                )
              : const SizedBox(width: 48),
          actions: [
            if (action != null && actionIcon != null)
              IconButton(
                onPressed: () => action(),
                icon: Icon(actionIcon),
                color: textColor ?? Colors.black,
              ),
            if (additionalAction != null && additionalIcon != null)
              GestureDetector(
                onTap: () => additionalAction(),
                child: additionalIcon,
              ),
            if (additionalAction != null && additionalIcon != null)
              GestureDetector(
                onTap: () => additionalAction(),
                child: additionalIcon,
              ),
          ],
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (titleText != null)
                Text(
                  titleText,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: AppColors.blackColor,
                      ),
                ),
              // if (showStepIndicator)
              //   Padding(
              //     padding: const EdgeInsets.only(top: 4.0),
              //     child: SizedBox(
              //       width: 200,
              //       height: 20,
              //       child: StepProgressIndicator(
              //         totalSteps: totalSteps,
              //         currentStep: currentStep + 1,
              //         size: 4,
              //         padding: 0,
              //         selectedColor: AppColors.primaryColor,
              //         unselectedColor: AppColors.lightgrayColor,
              //       ),
              //     ),
              //   ),
            ],
          ),
        );
}
