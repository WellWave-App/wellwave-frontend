import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final double width;
  final Color bgColor;
  final Color? outlineColor;
  final Color? textColor;

  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.title,
    required this.bgColor,
    this.outlineColor,
    this.textColor,
    this.width = 250.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(bgColor),
          elevation: WidgetStateProperty.all(0),
          padding: WidgetStateProperty.all(
              const EdgeInsets.symmetric(vertical: 16.0)),
          shape: WidgetStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
            side: outlineColor != null
                ? BorderSide(color: outlineColor!, width: 2.0)
                : BorderSide.none,
          )),
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: textColor,
              ),
        ),
      ),
    );
  }
}

class CustomButtonSmall extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final double width;
  final Color bgColor;
  final Color? outlineColor;
  final Color? textColor;

  const CustomButtonSmall({
    Key? key,
    required this.onPressed,
    required this.title,
    required this.bgColor,
    this.outlineColor,
    this.textColor,
    this.width = 120.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(bgColor),
          elevation: WidgetStateProperty.all(0),
          padding: WidgetStateProperty.all(
              const EdgeInsets.symmetric(vertical: 8.0)),
          shape: WidgetStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: outlineColor != null
                ? BorderSide(color: outlineColor!, width: 1.0)
                : BorderSide.none,
          )),
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: textColor,
              ),
        ),
      ),
    );
  }
}
