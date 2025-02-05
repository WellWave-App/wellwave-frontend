import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wellwave_frontend/common/widget/custom_button.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_pages.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void showAssessmentPopup(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.8),
    builder: (BuildContext context) {
      return Stack(
        children: [
          Center(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 196.0),
                  child: AlertDialog(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 128),
                        Text(
                          AppStrings.timeToAssessmentText,
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(
                                color: AppColors.blackColor,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          AppStrings.howMuchHaveYouChangedText,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppColors.blackColor,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24.0),
                        CardButton(
                          buttonText: AppStrings.gotoAssessmentPageText,
                          onPressed: () {
                            Navigator.pop(context);
                            context.goNamed(AppPages.assessmentPage);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "ปิดหน้าต่างนี้",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.grayColor,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.grayColor,
                        ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: (MediaQuery.of(context).size.height - 200.0) / 2 - 128,
            left: 0,
            right: 0,
            child: SvgPicture.asset(
              AppImages.avatarAssessmentImage,
              height: 172.0,
            ),
          )
        ],
      );
    },
  );
}
