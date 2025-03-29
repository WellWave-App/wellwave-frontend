import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_pages.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/home/widget/action_slider_button.dart';
import 'package:wellwave_frontend/features/home/widget/progress_stepper.dart';
import 'package:wellwave_frontend/features/mission/data/models/stats_request_model.dart';
import 'package:wellwave_frontend/features/mission/presentation/bloc/mission_bloc.dart';
import 'package:wellwave_frontend/features/mission/presentation/widgets/progress_stepper_dialog_widget.dart';

class TaskInfoDialog extends StatelessWidget {
  final String title;
  final int totalDays;
  final int expReward;
  final int taskId; // Add this
  final String adviceText; // Add this
  final int minutesGoal; // Add this
  final int challengeId; // Add this
  final int? defaultDailyMinuteGoal;
  final String category; // Add this
  final StatsRequestModel? statsData;

  const TaskInfoDialog({
    super.key,
    required this.title,
    required this.totalDays,
    required this.expReward,
    required this.taskId, // Add this
    required this.adviceText, // Add this
    required this.minutesGoal, // Add this
    required this.challengeId, // Add this
    required this.category, // Add this
    this.defaultDailyMinuteGoal,
    this.statsData, // Add this
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MissionBloc, MissionState>(
      builder: (context, state) {
        if (state is ActiveHabitLoaded) {
          state.dailyTracks.forEach((track) {});

          final now = DateTime.now();
          final today = DateTime(now.year, now.month, now.day);

          // Check if task is completed today using state.dailyTracks
          final bool isCompletedToday = state.dailyTracks.any((track) {
            final trackDateStr = track['TRACK_DATE'] as String;
            final trackDate = DateTime.parse(trackDateStr);
            final trackDateOnly =
                DateTime(trackDate.year, trackDate.month, trackDate.day);

            return trackDateOnly.isAtSameMomentAs(today);
          });

          // Get minutesGoal from state
          final minutesGoal =
              state.habitData['DAILY_MINUTE_GOAL'] ?? defaultDailyMinuteGoal;
          final daysGoal = state.habitData['DAYS_GOAL'] ?? totalDays;

          return Dialog(
            backgroundColor:
                Colors.transparent, // Make dialog background transparent
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Main white container
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          SvgPicture.asset(AppImages.calendarIcon),
                          const SizedBox(width: 8),
                          Text(
                            '$daysGoal วัน',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Text(
                        AppStrings.joinDateText,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      const SizedBox(height: 12),
                      ProgressStepperDialogWidget(
                        progressData: state.dailyTracks.map((track) {
                          debugPrint('Track data: $track');
                          return {
                            'TRACK_DATE': track['TRACK_DATE'],
                            'COMPLETED': track['COMPLETED'],
                            'TRACK_ID': track['TRACK_ID'],
                            'CHALLENGE_ID': track['CHALLENGE_ID'],
                          };
                        }).toList(),
                        progressId: challengeId.toString(),
                        totalDays: state.habitData['DAYS_GOAL'] ?? totalDays,
                        startDate: DateTime.parse(
                            state.habitData['START_DATE']), // กำหนด startDate
                        endDate: DateTime.parse(
                            state.habitData['END_DATE']), // กำหนด endDate
                      ),
                      const SizedBox(height: 24),
                      Text(
                        AppStrings.prizesToBeReceivedText,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppImages.expIcon,
                            width: 24,
                            height: 24,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${expReward * daysGoal} EXP',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      if (category == 'exercise')
                        TextButton(
                          onPressed: isCompletedToday
                              ? () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'คุณได้ทำภารกิจนี้ไปแล้วในวันนี้'),
                                    ),
                                  );
                                }
                              : () {
                                  Navigator.of(context).pop();
                                  context.goNamed(
                                    AppPages.missionRecordName,
                                    pathParameters: {'hid': taskId.toString()},
                                    extra: {
                                      'title': title,
                                      'adviceText': adviceText,
                                      'minutesGoal': minutesGoal,
                                      'challengeId': challengeId,
                                      'expReward': expReward,
                                      'totalDays': daysGoal,
                                    },
                                  );
                                },
                          style: TextButton.styleFrom(
                            backgroundColor: isCompletedToday
                                ? AppColors.lightgrayColor
                                : AppColors.primaryColor,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(isCompletedToday
                              ? 'ทำภารกิจไปแล้ววันนี้'
                              : 'ทำภารกิจ'),
                        )
                      else
                        isCompletedToday
                            ? TextButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'คุณได้ทำภารกิจนี้ไปแล้วในวันนี้'),
                                    ),
                                  );
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: AppColors.lightgrayColor,
                                  foregroundColor: Colors.white,
                                  minimumSize: const Size(double.infinity, 48),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  'ทำภารกิจไปแล้ววันนี้',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge
                                      ?.copyWith(
                                        color: AppColors.whiteColor,
                                      ),
                                ),
                              )
                            : ActionSliderMissionButton(
                                stepNumber: 1,
                                date: DateTime.now(),
                                progressId: challengeId.toString(),
                              ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Text(
                    AppStrings.closeWindowText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        // Show loading or default state
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
