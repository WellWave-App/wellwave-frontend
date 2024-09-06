import 'package:flutter/material.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';

class InputDailyLogs extends StatefulWidget {
  final int initialUnits;
  final IconData inputIcon;
  final Color inputColor;
  final int maxLevel;

  const InputDailyLogs({
    super.key,
    required this.initialUnits,
    this.inputIcon = Icons.water,
    this.inputColor = Colors.blue,
    this.maxLevel = 8
  });

  @override
  _InputDailyLogsState createState() => _InputDailyLogsState();
}

class _InputDailyLogsState extends State<InputDailyLogs> {
  late int inputLevel;

  @override
  void initState() {
    super.initState();
    inputLevel = widget.initialUnits;
  }

  void increaseinputLevel() {
    setState(() {
      if (inputLevel < widget.maxLevel) {
        inputLevel++;
      }
    });
  }

  void decreaseinputLevel() {
    setState(() {
      if (inputLevel > 0) {
        inputLevel--;
      }
    });
  }

  double calculateInputHeight() {
    return inputLevel / widget.maxLevel;
  }

  Widget buildInputIcon(double size) {
  return Stack(
    alignment: Alignment.bottomCenter,
    children: [
      Icon(
        widget.inputIcon,
        color: widget.inputColor.withOpacity(0.2),
        size: size, // Empty input icon
      ),
      Container(
        width: size/2,
        height: size * calculateInputHeight(), // Adjust height based on input level
        color: widget.inputColor,
      ),
    ],
  );
}

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          AppStrings.amoutOfWaterText,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildInputIcon(100),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle_outline,
                    color: Colors.grey, size: 48),
                onPressed: decreaseinputLevel,
              ),
              const SizedBox(width: 24.0),
              Text(
                '$inputLevel',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(width: 24.0),
              IconButton(
                icon: const Icon(Icons.add_circle_outline,
                    color: Colors.grey, size: 48),
                onPressed: increaseinputLevel,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppStrings.glassesText,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Colors.grey,
                    ),
              ),
            ],
          )
        ],
      ),
      actions: [
        TextButton(
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
            backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
          ),
          onPressed: () => Navigator.pop(context, inputLevel),
          child: const Center(child: Text(AppStrings.confirmText)),
        ),
      ],
    );
  }
}

