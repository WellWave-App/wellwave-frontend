import 'package:flutter/material.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';

class RiskCard extends StatelessWidget {
  final double progress;
  final String title;
  final String riskText;

  RiskCard(
      {required this.progress, required this.title, required this.riskText});

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
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.darkblueColor,
                ),
          ),
          SizedBox(height: 16),
          _buildProgressBar(progress),
          SizedBox(height: 16),
          Text(
            riskText,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.darkblueColor,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar(double value) {
    List<Color> colors;
    List<double> stops;

    if (value <= 0.4) {
      colors = [Colors.blue, Colors.green];
      stops = [0.0, 1.0];
    } else if (value <= 0.7) {
      colors = [Colors.blue, Colors.green, Colors.yellow];
      stops = [0.0, 0.5, 1.0];
    } else {
      colors = [
        Colors.blue,
        Colors.green,
        Colors.yellow,
        Colors.orange,
        Colors.red
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
