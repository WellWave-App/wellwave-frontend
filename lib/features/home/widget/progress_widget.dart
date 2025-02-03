import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wellwave_frontend/common/widget/custom_button.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_pages.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/config/constants/enums/greeting_message.dart';
import 'package:wellwave_frontend/features/home/data/models/challenge.dart';
import 'package:wellwave_frontend/features/home/data/models/progress.dart';
import 'package:wellwave_frontend/features/home/data/models/progress_step_ex.dart';
import 'package:wellwave_frontend/features/home/presentation/bloc/home_bloc.dart';
import 'package:wellwave_frontend/features/home/widget/challenge_show_card.dart';
import 'package:wellwave_frontend/features/home/widget/health_data/exercise_steps/progress_ex_card.dart';
import 'package:wellwave_frontend/features/home/widget/health_data/exercise_steps/progress_step_card.dart';
import 'package:wellwave_frontend/features/home/widget/health_data/exercise_steps/progress_step_ex_card_data.dart';
import 'package:wellwave_frontend/features/home/widget/health_data/health_data_card.dart';
import 'package:wellwave_frontend/features/home/widget/health_data/mock_data.dart';
import 'package:wellwave_frontend/features/home/widget/mockup_data/challenge_data.dart';
import 'package:wellwave_frontend/features/home/widget/mockup_data/progress_data.dart';
import 'package:wellwave_frontend/features/home/widget/progress_show_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

bool _isSameDay(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}

class ProgressWidget extends StatefulWidget {
  const ProgressWidget({super.key});

  @override
  _ProgressWidgetState createState() => _ProgressWidgetState();
}

class _ProgressWidgetState extends State<ProgressWidget> {
  late String greetingMessage;
  late String dailyMessage;

  @override
  void initState() {
    super.initState();
    greetingMessage = GreetingTimeText.getGreetingMessage();
    dailyMessage = DailyMessage().getMessage();
  }

  @override
  Widget build(BuildContext context) {
    final List<Progress> progressList = getMockProgressData();
    final List<Challenge> challengeList = getMockChallengeData();
    final List<ProgressStepEx> progressStepExList =
        getMockProgressStepExCardData();

    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            // Main Content Container
            Padding(
              padding: const EdgeInsets.only(top: 128.0),
              child: Container(
                padding: const EdgeInsets.only(top: 40),
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppStrings.progressText,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(color: AppColors.blackColor),
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
                    const SizedBox(height: 16),
                    progressList.isNotEmpty
                        ? SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 24.0,
                                  top: 8.0,
                                  bottom: 8.0,
                                  right: 24.0),
                              child: Row(
                                children: [
                                  ...progressList.map((progress) {
                                    final dates = List.generate(
                                      progress.totalDays,
                                      (index) => progress.startDate
                                          .add(Duration(days: index)),
                                    );
                                    final hasDateNow = dates.any((date) =>
                                        _isSameDay(date, DateTime.now()));

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
                                      (index) => progress.startDate
                                          .add(Duration(days: index)),
                                    );
                                    return !dates.any((date) =>
                                        _isSameDay(date, DateTime.now()));
                                  }))
                                    Container(
                                      height: 200,
                                      width: MediaQuery.of(context).size.width -
                                          48,
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
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: AppColors.darkgrayColor,
                                    ),
                              ),
                            ),
                          ),
                    const SizedBox(
                      height: 32,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        AppStrings.challengeText,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
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
                                  left: 24.0,
                                  top: 8.0,
                                  bottom: 8.0,
                                  right: 24.0),
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
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: AppColors.darkgrayColor,
                                  ),
                            ),
                          ),
                    const SizedBox(
                      height: 32,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        AppStrings.healthdataText,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              color: AppColors.blackColor,
                            ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Container(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (progressStepExList.isNotEmpty) ...[
                                  Expanded(
                                    child: ProgressStepCard(
                                      progressStepExData:
                                          progressStepExList.first,
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: ProgressExCard(
                                      progressStepExData:
                                          progressStepExList.first,
                                    ),
                                  ),
                                ] else
                                  Container(),
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
                                      child:
                                          Text('Error: ${state.errorMessage}'));
                                }
                                return Center(
                                    child: CircularProgressIndicator());
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            // Greeting Section
            Padding(
              padding: const EdgeInsets.only(
                  top: 12, left: 24, right: 24, bottom: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$greetingMessage, แจน',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(color: AppColors.whiteColor),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$dailyMessage',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(color: AppColors.whiteColor),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Text(
                            '10',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(color: AppColors.whiteColor),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'วันต่อเนื่อง',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: AppColors.whiteColor),
                          ),
                          const SizedBox(width: 8),
                          SvgPicture.asset(
                            AppImages.fireIcon,
                            height: 16,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              right: 24,
              child: Transform.translate(
                offset: const Offset(0, 0),
                child: SvgPicture.asset(
                  AppImages.avatarImage,
                  height: 152,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
