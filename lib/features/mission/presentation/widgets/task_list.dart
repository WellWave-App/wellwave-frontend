import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wellwave_frontend/features/mission/presentation/bloc/mission_bloc.dart';

import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/app_images.dart';
import '../../../../config/constants/app_strings.dart';
import '../../data/mockup_data.dart';
import 'mission_dialog.dart';
import 'task_goal_bottom_sheet.dart';

class TaskList extends StatelessWidget {
  final String imagePath;
  final int taskId;
  final String taskName;
  const TaskList(
      {super.key,
      required this.imagePath,
      required this.taskId,
      required this.taskName});

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
    double progressValue = 0.3;
    double progressBarWidth = MediaQuery.of(context).size.width - 40;

    return BlocBuilder<MissionBloc, MissionState>(
      builder: (context, state) {
        bool isProgressVisible = state is ProgressState;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
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
                        child: Image.asset(
                          imagePath,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 8), // Add spacing if needed
                      Flexible(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start, // Align to start
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                Row(
                                  children: [
                                    Image.asset(AppImages.expImage),
                                    Text(
                                      ' x${mockTasks.firstWhere((task) => task['taskId'] == taskId)['exp']}',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            isProgressVisible
                                ? Container(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                                width: 16,
                                                AppImages.calendarIcon),
                                            SizedBox(width: 4),
                                            Text(
                                              '5 วัน',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                            ),
                                            SizedBox(width: 12),
                                            SvgPicture.asset(
                                                width: 16, AppImages.clockIcon),
                                            SizedBox(width: 4),
                                            Text(
                                              '10 นาที',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 12),
                                        Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            // Progress bar
                                            Container(
                                              width: progressBarWidth,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: LinearProgressIndicator(
                                                  backgroundColor: AppColors
                                                      .grayProgressColor,
                                                  color: AppColors.skyBlueColor,
                                                  minHeight: 16,
                                                  value: progressValue,
                                                ),
                                              ),
                                            ),
                                            // Icon ด้านบน progress bar
                                            Positioned(
                                              left: progressValue + 42,
                                              top: -8,
                                              child: Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                                size: 32,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                : SizedBox(
                                    height: 28,
                                    width: double
                                        .infinity, // Adjusts to available space
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
                                        backgroundColor: AppColors.primaryColor,
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
        );
      },
    );
  }
}
