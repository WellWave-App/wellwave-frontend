import 'package:flutter/material.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/logs/presentation/screen/logs_history_screen.dart';

class HistoryButton extends StatelessWidget {
  const HistoryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all<Color>(Colors.grey),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const LogsHistoryScreen()),
            );
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