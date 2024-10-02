import 'package:flutter/material.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';

class WeeklyLogsCard extends StatelessWidget {
  final String title;
  final double value;
  final String unit;
  final double lastWeekValue;
  final Widget chart;

  const WeeklyLogsCard({
    Key? key,
    required this.title,
    required this.value,
    required this.unit,
    required this.lastWeekValue,
    required this.chart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double difference = value - lastWeekValue;
    bool isPositive = difference >= 0;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              offset: const Offset(0, 0),
              blurRadius: 4,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  '$value',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                const SizedBox(width: 4),
                Text(
                  unit,
                  style: Theme.of(context).textTheme.caption2?.copyWith(
                        color: Colors.black,
                      ),
                ),
                const SizedBox(width: 2),
                Row(
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
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: chart),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
