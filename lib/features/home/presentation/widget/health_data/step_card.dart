import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';

class StepCard extends StatelessWidget {
  final int currentSteps;
  final int goalSteps;
  final String unitText;
  final String unitImage;

  const StepCard({
    Key? key,
    required this.currentSteps,
    required this.unitText,
    required this.unitImage,
    required this.goalSteps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // ข้อมูลข้อความ
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '$currentSteps ',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                    ),
                    TextSpan(
                      text: '/ $goalSteps',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: Colors.grey,
                              ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                unitText,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: SvgPicture.asset(
              unitImage,
              height: 24,
            ),
          ),
        ],
      ),
    );
  }
}
