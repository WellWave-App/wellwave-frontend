import 'package:flutter/material.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';

class WeeklyLogsCard extends StatelessWidget {
  final String title;
  final String value;
  final String unit;
  final Widget chart;

  const WeeklyLogsCard({
    Key? key,
    required this.title,
    required this.value,
    required this.unit,
    required this.chart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(

                      ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  value,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      ),
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
                    const Icon(Icons.arrow_downward,
                        size: 10.0, color: AppColors.greenColor),
                    Text(
                      '0.5 $unit',
                      style: Theme.of(context).textTheme.caption2?.copyWith(
                            color: AppColors.greenColor,
                            fontSize: 8
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
