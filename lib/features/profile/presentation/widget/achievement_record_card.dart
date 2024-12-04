import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ArchievementRecordCard extends StatelessWidget {
  final Color backgroundColor;
  final Color borderColor;
  final String svgPath;
  final double svgWidth;
  final double? svgHeight;
  final String archievementName;

  const ArchievementRecordCard({
    super.key,
    required this.svgPath,
    this.svgWidth = 72,
    this.svgHeight,
    required this.archievementName,
    this.backgroundColor = const Color(0x33FFC466),
    this.borderColor = const Color.fromARGB(68, 196, 102, 51),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Container(
        height: 169,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              svgPath,
              width: svgWidth,
              height: svgHeight,
            ),
            const SizedBox(height: 13),
            Text(
              archievementName,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
