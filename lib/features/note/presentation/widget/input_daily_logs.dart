import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';

class InputDailyLogs extends StatefulWidget {
  final int initialUnits;
  final String title;
  final String unitLabel;
  final int maxLevel;
  final List<String> svgIcons; // List of SVG paths for each level

  const InputDailyLogs({
    super.key,
    required this.initialUnits,
    required this.title,
    required this.unitLabel,
    this.maxLevel = 11,
    required this.svgIcons, // SVG icons need to be passed
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

  void increaseInputLevel() {
    setState(() {
      if (inputLevel < widget.maxLevel - 1) {
        inputLevel++;
      }
    });
  }

  void decreaseInputLevel() {
    setState(() {
      if (inputLevel > 0) {
        inputLevel--;
      }
    });
  }

  Widget buildInputIcon(double size) {
    // Use the SVG based on the current level
    return SvgPicture.asset(
      widget.svgIcons[inputLevel], // Display the SVG for the current level
      width: size,
      height: size,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          widget.title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildInputIcon(100), // Display the SVG icon
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle_outline,
                    color: Colors.grey, size: 48),
                onPressed: decreaseInputLevel,
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
                onPressed: increaseInputLevel,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.unitLabel,
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
