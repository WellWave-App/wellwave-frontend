import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wellwave_frontend/config/constants/app_url.dart';
import 'package:wellwave_frontend/features/mission/presentation/bloc/mission_bloc.dart';

import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/app_images.dart';
import '../../../../config/constants/app_strings.dart';
import '../../data/daily_mockup_data.dart';
import 'mission_dialog.dart';
import 'task_goal_bottom_sheet.dart';

class TaskList extends StatelessWidget {
  final String imagePath;
  final int taskId;
  final String taskName;
  final int? expReward;
  final int? gemReward;
  final VoidCallback? onTap;
  final bool? isActive; // Add isActive property
  final double? progressPercentage; // Add new property

  const TaskList({
    super.key,
    required this.imagePath,
    required this.taskId,
    required this.taskName,
    this.expReward,
    this.gemReward,
    this.onTap,
    this.isActive, // Add to constructor
    this.progressPercentage, // Add to constructor
  });

  Color _getProgressColor(double progress) {
    if (progress <= 0.3) {
      return Colors.red;
    } else if (progress <= 0.6) {
      return Colors.yellow;
    } else {
      return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    double progressValue = progressPercentage ?? 0.0;
    double progressBarWidth = MediaQuery.of(context).size.width - 40;

    return BlocBuilder<MissionBloc, MissionState>(
      builder: (context, state) {
        bool isProgressVisible = state is ProgressState || isActive == true;
        return GestureDetector(
          onTap: onTap,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.25),
                    spreadRadius: 0.5,
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColors.transparentColor,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                '$baseUrl${imagePath}',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(
                                  Icons.error,
                                  size: 32,
                                  color: AppColors.darkGrayColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Flexible(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      taskName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  if (expReward != null && gemReward == null)
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          AppImages.expIcon,
                                          width: 20,
                                        ),
                                        Text(
                                          ' +$expReward/วัน',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                      ],
                                    ),
                                  if (expReward == null && gemReward != null)
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          AppImages.gemIcon,
                                          width: 20,
                                        ),
                                        Text(
                                          ' +$gemReward/วัน',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                              SizedBox(height: 16),
                              isProgressVisible
                                  ? Container(
                                      child: Column(
                                        children: [
                                          Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              Container(
                                                width: progressBarWidth,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child:
                                                      LinearProgressIndicator(
                                                    backgroundColor: AppColors
                                                        .grayProgressColor,
                                                    color:
                                                        AppColors.skyBlueColor,
                                                    minHeight: 16,
                                                    value: progressValue,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: (progressBarWidth *
                                                    progressValue),
                                                top: -6,
                                                child: SvgPicture.asset(
                                                    AppImages.processIcon,
                                                    height: 24),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  : SizedBox(
                                      height: 28,
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          showModalBottomSheet(
                                            context: context,
                                            isScrollControlled: true,
                                            barrierColor:
                                                Colors.black.withOpacity(0.3),
                                            builder: (BuildContext context) {
                                              return const TaskGoalBottomSheet();
                                            },
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColors.primaryColor,
                                          foregroundColor: AppColors.whiteColor,
                                          minimumSize: const Size(64, 28),
                                          side: const BorderSide(
                                            color: AppColors.whiteColor,
                                            width: 2.0,
                                          ),
                                          elevation: 2,
                                          shadowColor: AppColors.darkGrayColor,
                                        ),
                                        child: Text(
                                          AppStrings.chooseText,
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall
                                              ?.copyWith(
                                                  color: AppColors.whiteColor),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
