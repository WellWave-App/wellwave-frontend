import 'package:flutter/material.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/enums/risk_condition.dart';

class RiskCard extends StatelessWidget {
  final double progress;
  final String title;

  const RiskCard({
    super.key,
    required this.progress,
    required this.title,
  });

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
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.blackColor,
                    ),
              ),
              Text(
                RiskTextCondition.getRiskText(progress)['text'],
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: RiskTextCondition.getRiskText(progress)['color'],
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
        AppColors.blueLevelColor,
        AppColors.greenLevelColor,
      ];
      stops = [0.0, 1.0];
    } else if (value <= 0.7) {
      colors = [
        AppColors.blueLevelColor,
        AppColors.greenLevelColor,
        AppColors.yellowLevelColor,
      ];
      stops = [0.0, 0.5, 1.0];
    } else {
      colors = [
        AppColors.blueLevelColor,
        AppColors.greenLevelColor,
        AppColors.yellowLevelColor,
        AppColors.orangeLevelColor,
        AppColors.pinkLevelColor,
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
