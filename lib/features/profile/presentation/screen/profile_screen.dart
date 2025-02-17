import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellwave_frontend/common/widget/app_bar.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_pages.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:wellwave_frontend/features/profile/presentation/bloc/profile_bloc/profile_event.dart';
import 'package:wellwave_frontend/features/profile/presentation/bloc/profile_bloc/profile_state.dart';
import 'package:wellwave_frontend/features/profile/presentation/widget/acievement/achievement_card.dart';
import 'package:wellwave_frontend/features/profile/presentation/widget/profile/chart_section_widget.dart';
import 'package:wellwave_frontend/features/profile/presentation/widget/profile/check_in_card.dart';

import 'package:wellwave_frontend/features/profile/presentation/widget/profile/progress_card.dart';
import 'package:wellwave_frontend/features/profile/presentation/widget/profile/round_border_text.dart';
import 'package:wellwave_frontend/features/profile/presentation/widget/profile/user_info.dart';

import '../../../logs/presentation/bloc/logs_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  double totalSteps = 0.0;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ProfileBloc>().add(FetchUserProfile());
      final today = DateTime.now();
      context.read<LogsBloc>().add(LogsFetchedGraph(today));
      context.read<LogsBloc>().add(LogsFetched(today));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(title: '', context: context, onLeading: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: BlocBuilder<LogsBloc, LogsState>(
            builder: (context, state) {
              if (state is LogsLoadSuccess) {
                final currentWeekLogs = state.logsWeeklyList;
                totalSteps = 0.0;
                for (var log in currentWeekLogs) {
                  if (log?.logName == AppStrings.stepLogText) {
                    totalSteps += log?.value ?? 0.0;
                  }
                }
              }

              return BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileLoaded) {
                    final profile = state.userProfile;

                    final userLeague = profile.userLeague;

                    int leagueIndex =
                        _getLeagueIndex(userLeague?.name ?? 'Bronze');

                    return Column(
                      children: [
                        const SizedBox(height: 24),
                        UserInformation(
                          userID: 'UID${profile.uid}',
                          userName: profile.username,
                          gemAmount: profile.gem,
                          expAmount: profile.exp,
                          state: state,
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            //leaderboard
                            Expanded(
                              child: RoundedText(
                                text: AppStrings.leaderboardText,
                                svgPath: AppImages.leagueListIcon[leagueIndex],
                                isShowNavi: true,
                                appPages: AppPages.leaderboardlPage,
                                horizontal: 12,
                              ),
                            ),
                            const SizedBox(width: 16),

                            //exchange
                            const Expanded(
                              child: RoundedText(
                                text: AppStrings.rewardRedeemText,
                                svgPath: AppImages.giftIcon,
                                isShowNavi: true,
                                appPages: AppPages.articleName,
                                horizontal: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        //CheckIn
                        CheckInWidget(profileState: state),
                        const SizedBox(height: 24),

                        //progress

                        ProgressCard(
                          daysRemain:
                              state.userProfile.weeklyGoal?.daysLeft ?? 0,
                          exerciseTime: state.userProfile.weeklyGoal?.progress
                                  .exerciseTime.current ??
                              0,
                          taskAmount: state.userProfile.weeklyGoal?.progress
                                  .mission.current ??
                              0,
                          maxExerciseTime:
                              state.userProfile.exercisePerWeek ?? 0,
                          maxTaskAmount: state.userProfile.weeklyGoal?.progress
                                  .mission.goal ??
                              0,
                          maxStepCount: state.userProfile.stepPerWeek ?? 0,
                          stepAmount: totalSteps.toInt(),
                        ),
                        const SizedBox(height: 24),
                        const AchievementCard(),
                        const SizedBox(height: 24),

                        //chart
                        const ChartSectionWidget(),
                        const SizedBox(height: 16),

                        //noti
                        const RoundedText(
                          text: AppStrings.alertText,
                          svgPath: AppImages.alarmIcon,
                          isShowNavi: true,
                          appPages: AppPages.reminderName,
                          iconSize: 32,
                          vertical: 16,
                          radius: 16,
                          isBold: true,
                        ),
                        const SizedBox(height: 16),

                        //goal
                        const RoundedText(
                          text: AppStrings.goalText,
                          svgPath: AppImages.goalIcon,
                          isShowNavi: true,
                          appPages: AppPages.setWeeklyGoalName,
                          iconSize: 32,
                          vertical: 16,
                          radius: 16,
                          isBold: true,
                        ),
                        const SizedBox(height: 36),

                        //sign out
                        GestureDetector(
                          onTap: () {
                            context.read<ProfileBloc>().add(LogOutEvent());

                            Future.delayed(const Duration(milliseconds: 300),
                                () {
                              Navigator.pop(context);
                            });
                          },
                          child: Text(
                            AppStrings.signOutText,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: AppColors.darkGrayColor),
                          ),
                        ),
                        const SizedBox(height: 36),
                      ],
                    );
                  } else if (state is ProfileError) {
                    return Center(child: Text(state.errorMessage));
                  } else if (state is ProfileLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return const Center(
                        child: Text(AppStrings.noDataAvaliableText));
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }

  int _getLeagueIndex(String leagueName) {
    switch (leagueName.toLowerCase()) {
      case 'bronze':
        return 0;
      case 'silver':
        return 1;
      case 'gold':
        return 2;
      case 'diamond':
        return 3;
      case 'emerald':
        return 4;
      default:
        return 0;
    }
  }
}
