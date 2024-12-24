import 'package:flutter/material.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';

import 'custom_dropdown.dart';

class ProgressChartCard extends StatefulWidget {
  final String title;
  final double value;
  final String unit;
  final double lastWeekValue;
  final Widget chart;

  const ProgressChartCard({
    Key? key,
    required this.title,
    required this.value,
    required this.unit,
    required this.lastWeekValue,
    required this.chart,
  }) : super(key: key);

  @override
  State<ProgressChartCard> createState() => _ProgressChartCardState();
}

class _ProgressChartCardState extends State<ProgressChartCard> {
  @override
  Widget build(BuildContext context) {
    double difference = widget.value - widget.lastWeekValue;
    bool isPositive = difference >= 0;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.title,
                        style:
                            Theme.of(context).textTheme.titleSmall?.copyWith(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${widget.value}',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.unit,
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
                            color:
                                isPositive ? Colors.red : AppColors.greenColor,
                          ),
                          Text(
                            '${difference.abs()} ${widget.unit}',
                            style:
                                Theme.of(context).textTheme.caption2?.copyWith(
                                      color: isPositive
                                          ? Colors.red
                                          : AppColors.greenColor,
                                    ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const CustomDropdownButton(),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: widget.chart),
            ],
          ),
        ],
      ),
    );
  }
}
