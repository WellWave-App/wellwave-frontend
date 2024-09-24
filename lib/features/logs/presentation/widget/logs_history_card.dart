import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';

class LogsHistoryCard extends StatelessWidget {
  final String svgPath; // Path for SVG asset
  final String pngPath; // Path for PNG asset
  final String title; // Main text to display
  final double value; // Value to display
  final String unit; // Unit for the value
  final double svgWidth; // Width for the SVG
  final double svgHeight; // Height for the SVG
  final double pngWidth; // Width for the PNG
  final double pngHeight; // Height for the PNG
  final bool isSvg; // Flag to determine if the image is SVG
  final TextStyle? mainTextStyle; // Style for the main text
  final TextStyle? subTextStyle; // Style for the subtext

  const LogsHistoryCard({
    Key? key,
    required this.title,
    required this.value,
    required this.unit,
    required this.isSvg, // New parameter to determine image type
    this.svgPath = '', // SVG path (default empty)
    this.pngPath = '', // PNG path (default empty)
    this.svgWidth = 64.0, // Default SVG width
    this.svgHeight = 64.0, // Default SVG height
    this.pngWidth = 64.0, // Default PNG width
    this.pngHeight = 64.0, // Default PNG height
    this.mainTextStyle,
    this.subTextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: AppColors.tertiaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Conditional rendering based on isSvg
            isSvg
                ? SvgPicture.asset(
                    svgPath,
                    width: svgWidth,
                    height: svgHeight,
                  )
                : Image.asset(
                    pngPath,
                    width: pngWidth,
                    height: pngHeight,
                  ),
            const SizedBox(width: 16.0),
            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align text to the start
              children: [
                Text(
                  title,
                  style: mainTextStyle ??
                      Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.darkGrayColor,
                          ),
                ),
                Text(
                  '$value $unit',
                  style: subTextStyle ??
                      Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
