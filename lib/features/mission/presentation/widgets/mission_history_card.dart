import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';

class MissionHistoryCard extends StatelessWidget {
  final String svgPath;
  final String title;
  final String state;

  const MissionHistoryCard({
    Key? key,
    required this.svgPath,
    required this.title,
    required this.state,
  }) : super(key: key);

  String _getStateText(String state) {
    switch (state.toLowerCase()) {
      case 'active':
        return 'กำลังทำ';
      case 'completed':
        return 'สำเร็จ';
      case 'failed':
        return 'ล้มเหลว';
      case 'canceled':
        return 'ยกเลิก';
      default:
        return state;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.tertiaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(8),
            child: SvgPicture.asset(
              svgPath,
              width: 64,
              height: 64,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.headlineMedium),
              ],
            ),
          ),
          Text(
            _getStateText(state),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.blueGrayColor,
                ),
          ),
        ],
      ),
    );
  }
}
