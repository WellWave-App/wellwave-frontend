import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wellwave_frontend/common/widget/gradient_circular_progress_indicator.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/features/home/data/models/progress.dart';
import 'package:wellwave_frontend/features/home/widget/progress_stepper.dart';

class ProgressShowCard extends StatelessWidget {
  final Progress progress;

  const ProgressShowCard({Key? key, required this.progress}) : super(key: key);

  bool _hasDateNow(Progress progress) {
    final dates = List.generate(
      progress.totalDays,
      (index) => progress.startDate.add(Duration(days: index)),
    );
    return dates.any((date) => _isSameDay(date, DateTime.now()));
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  @override
  Widget build(BuildContext context) {
    // if (!_hasDateNow(progress)) {
    //   return SizedBox.shrink();
    // }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.5,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 4,
                child: Text(
                  progress.taskDescription,
                  textAlign: TextAlign.left,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: AppColors.blackColor,
                      ),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                flex: 1,
                child: GradientCircularProgressWithText(
                  value: progress.progress,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              if (progress.rewardType == 'EXP')
                SvgPicture.asset(
                  AppImages.expIcon,
                  height: 20,
                ),
              if (progress.rewardType == 'GEM')
                SvgPicture.asset(
                  AppImages.gemIcon,
                  height: 20,
                ),
              const SizedBox(
                width: 4,
              ),
              Text(
                progress.rewards.toString(),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.blackColor,
                    ),
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                progress.rewardType,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.blackColor,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ProgressStepperWidget(
              progress: progress, progressId: progress.id.toString()),
        ],
      ),
    );
  }
}
