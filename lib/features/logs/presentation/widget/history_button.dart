import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_pages.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';

class HistoryButton extends StatelessWidget {
  const HistoryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all<Color>(Colors.grey),
          ),
          onPressed: () {
            context.goNamed(AppPages.logHistoryName);
          },
          child: Text(
            AppStrings.historyText,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.greyColor,
                ),
          ),
        );
  }
}