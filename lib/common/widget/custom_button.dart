import 'package:flutter/material.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final double width; // Add a width parameter

  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.title,
    this.width = 250.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColors.backgroundColor,
          backgroundColor: AppColors.primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.backgroundColor,
              ),
        ),
      ),
    );
  }
}
