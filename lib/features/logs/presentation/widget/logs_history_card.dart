import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';

class LogsHistoryCard extends StatelessWidget {
  final String svgPath; 
  final String pngPath; 
  final String title; 
  final double value; 
  final double lastWeekValue;
  final String unit; 
  final double svgWidth; 
  final double svgHeight; 
  final double pngWidth; 
  final double pngHeight; 
  final bool isSvg; 
  final bool isShow; 
  final TextStyle? mainTextStyle; 
  final TextStyle? subTextStyle; 

  const LogsHistoryCard({
    Key? key,
    required this.title,
    required this.value,
    this.lastWeekValue = 0.0,
    required this.unit,
    required this.isSvg, 
    this.svgPath = '', 
    this.pngPath = '', 
    this.svgWidth = 64.0, 
    this.svgHeight = 64.0, 
    this.pngWidth = 64.0, 
    this.pngHeight = 64.0, 
    this.mainTextStyle,
    this.subTextStyle, required this.isShow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double difference = value - lastWeekValue;
    bool isPositive = difference >= 0;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: AppColors.tertiaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            
            Row(
              children: [
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
                  CrossAxisAlignment.start, 
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
            
            isShow
            ?Row(
              mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      isPositive
                          ? Icons.arrow_upward
                          : Icons.arrow_downward,
                      size: 16,
                      color: isPositive
                          ? Colors.red
                          : AppColors.greenColor,
                    ),
                    Text(
                      '${difference.abs()} $unit',
                      style: Theme.of(context).textTheme.caption2?.copyWith(
                            color: isPositive
                                ? Colors.red
                                : AppColors.greenColor,
                          ),
                    ),
                  ],
                )
                : Container()
          ],
        ),
      ),
    );
  }
}
