import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wellwave_frontend/common/widget/custom_button.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_pages.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/home/data/models/challenge.dart';
import 'package:wellwave_frontend/features/home/data/models/progress.dart';
import 'package:wellwave_frontend/features/home/data/models/progress_step_ex.dart';
import 'package:wellwave_frontend/features/home/presentation/bloc/home_bloc.dart';
import 'package:wellwave_frontend/features/home/widget/mockup_data/challenge_data.dart';
import 'package:wellwave_frontend/features/home/widget/challenge_show_card.dart';
import 'package:wellwave_frontend/features/home/widget/health_data/exercise_steps/progress_ex_card.dart';
import 'package:wellwave_frontend/features/home/widget/health_data/health_data_card.dart';
import 'package:wellwave_frontend/features/home/widget/health_data/mock_data.dart';
import 'package:wellwave_frontend/features/home/widget/health_data/exercise_steps/progress_step_card.dart';
import 'package:wellwave_frontend/features/home/widget/health_data/exercise_steps/progress_step_ex_card_data.dart';
import 'package:wellwave_frontend/features/home/widget/mockup_data/progress_data.dart';
import 'package:wellwave_frontend/features/home/widget/progress_show_card.dart';

class ProgressWidget extends StatelessWidget {
  const ProgressWidget({super.key});

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  @override
  Widget build(BuildContext context) {
    final newData = mockData;
    context.read<HomeBloc>().add(UpdateHealthDataEvent(newData));
    final List<Progress> progressList = getMockProgressData();
    final List<Challenge> challengeList = getMockChallengeData();
    final List<ProgressStepEx> progressStepExList =
        getMockProgressStepExCardData();

    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.progressText,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: AppColors.blackColor,
                      ),
                ),
                InputButton(
                  buttonText: 'เพิ่ม',
                  onPressed: () {
                    context.goNamed(AppPages.missionPage);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          progressList.isNotEmpty
              ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 24.0, top: 8.0, bottom: 8.0, right: 24.0),
                    child: Row(
                      children: [
                        ...progressList.map((progress) {
                          final dates = List.generate(
                            progress.totalDays,
                            (index) =>
                                progress.startDate.add(Duration(days: index)),
                          );
                          final hasDateNow = dates
                              .any((date) => _isSameDay(date, DateTime.now()));

                          if (!hasDateNow) {
                            return SizedBox.shrink();
                          }

                          return Row(
                            children: [
                              ProgressShowCard(progress: progress),
                              const SizedBox(width: 16),
                            ],
                          );
                        }).toList(),
                        if (progressList.every((progress) {
                          final dates = List.generate(
                            progress.totalDays,
                            (index) =>
                                progress.startDate.add(Duration(days: index)),
                          );
                          return !dates
                              .any((date) => _isSameDay(date, DateTime.now()));
                        }))
                          Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width - 48,
                            child: Center(
                              child: Text(
                                'ยังไม่มีความคืบหน้า ไปเริ่มทำกันเลย!',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: AppColors.darkgrayColor,
                                    ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                )
              : Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width - 48,
                  child: Center(
                    child: Text(
                      'ยังไม่มีความคืบหน้า ไปเริ่มทำกันเลย!',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.darkgrayColor,
                          ),
                    ),
                  ),
                ),
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24),
            child: Text(
              AppStrings.challengeText,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppColors.blackColor,
                  ),
            ),
          ),
          const SizedBox(height: 16),
          challengeList.isNotEmpty
              ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 24.0, top: 8.0, bottom: 8.0, right: 24.0),
                    child: Row(
                      children: challengeList.map((challenge) {
                        return Row(
                          children: [
                            ChallengeShowCard(challenge: challenge),
                            const SizedBox(width: 16),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                )
              : Container(
                  alignment: Alignment.center,
                  height: 120,
                  child: Text(
                    'ยังไม่มีรายการ',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.darkgrayColor,
                        ),
                  ),
                ),
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Text(
              AppStrings.healthdataText,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppColors.blackColor,
                  ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
            child: Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (progressStepExList.isNotEmpty) ...[
                        Expanded(
                          child: ProgressStepCard(
                            progressStepExData: progressStepExList.first,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: ProgressExCard(
                            progressStepExData: progressStepExList.first,
                          ),
                        ),
                      ] else
                        Text(
                          "No data available",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      if (state is HomeLoadedState) {
                        return HealthDataCard(
                            weeklyAverages: state.weeklyAverages);
                      } else if (state is HomeErrorState) {
                        return Center(
                            child: Text('Error: ${state.errorMessage}'));
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
