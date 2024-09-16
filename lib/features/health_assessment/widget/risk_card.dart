import 'package:flutter/material.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';

class RiskCard extends StatelessWidget {
  final double progress;
  final String title;
  final String riskText;

  const RiskCard(
      {super.key,
      required this.progress,
      required this.title,
      required this.riskText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            spreadRadius: 0,
            blurRadius: 5,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppColors.blackColor,
                    ),
              ),
              Text(
                riskText,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.blackColor,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildProgressBar(progress),
        ],
      ),
    );
  }

  Widget _buildProgressBar(double value) {
    List<Color> colors;
    List<double> stops;

    if (value <= 0.4) {
      colors = [
        const Color.fromARGB(255, 56, 208, 190),
        const Color.fromARGB(255, 155, 202, 146),
      ];
      stops = [0.0, 1.0];
    } else if (value <= 0.7) {
      colors = [
        const Color.fromARGB(255, 56, 208, 190),
        const Color.fromARGB(255, 155, 202, 146),
        const Color.fromARGB(255, 255, 196, 102),
      ];
      stops = [0.0, 0.5, 1.0];
    } else {
      colors = [
        const Color.fromARGB(255, 56, 208, 190),
        const Color.fromARGB(255, 155, 202, 146),
        const Color.fromARGB(255, 255, 196, 102),
        const Color.fromARGB(255, 255, 162, 135),
        const Color.fromARGB(255, 255, 128, 169),
      ];
      stops = [0.0, 0.3, 0.6, 0.8, 1.0];
    }

    return Stack(
      children: [
        Container(
          height: 6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.grey[300],
          ),
        ),
        Container(
          height: 6,
          width: value * 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            gradient: LinearGradient(
              colors: colors,
              stops: stops,
            ),
          ),
        ),
      ],
    );
  }
}
