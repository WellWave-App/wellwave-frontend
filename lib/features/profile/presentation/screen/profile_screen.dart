import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wellwave_frontend/common/widget/app_bar.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_pages.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'package:wellwave_frontend/features/profile/presentation/bloc/profile/profile_event.dart';
import 'package:wellwave_frontend/features/profile/presentation/bloc/profile/profile_state.dart';
import 'package:wellwave_frontend/features/profile/presentation/widget/acievement/achievement_card.dart';
import 'package:wellwave_frontend/features/profile/presentation/widget/profile/chart_section_widget.dart';
import 'package:wellwave_frontend/features/profile/presentation/widget/profile/check_in_card.dart';

import 'package:wellwave_frontend/features/profile/presentation/widget/profile/progress_card.dart';
import 'package:wellwave_frontend/features/profile/presentation/widget/profile/round_border_text.dart';
import 'package:wellwave_frontend/features/profile/presentation/widget/profile/user_info.dart';

import '../../../logs/presentation/logs_bloc/logs_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    context.read<ProfileBloc>().add(FetchUserProfile());

    int currentDay = 4;

    final today = DateTime.now();

    context.read<LogsBloc>().add(LogsFetchedGraph(today));
    // debugPrint('Dispatched LogsFetchedGraph event');

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(title: '', context: context, onLeading: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoaded) {
                final profile = state.userProfile;

                final userLeague = profile.userLeague;

                List<String> leagueList = [
                  AppStrings.bronzeLeaugeText,
                  AppStrings.silverLeaugeText,
                  AppStrings.goldLeaugeText,
                  AppStrings.diamondLeaugeText,
                  AppStrings.emeraldLeaugeText,
                ];

                List<String> leagueListIcon = [
                  AppImages.bronzeLeaugeIcon,
                  AppImages.silverLeaugeIcon,
                  AppImages.goldLeaugeIcon,
                  AppImages.diamondLeagueIcon,
                  AppImages.emeraldLeaugeIcon,
                ];

                int leagueIndex = _getLeagueIndex(userLeague?.name ?? 'Bronze');

                // debugPrint('Loaded profile: ${profile.username}');
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: RoundedText(
                            text:
                                '${AppStrings.leagueText}${leagueList[leagueIndex]}',
                            svgPath: leagueListIcon[leagueIndex],
                            isShowNavi: true,
                            appPages: AppPages.articleName,
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Expanded(
                          child: RoundedText(
                            text: AppStrings.rewardRedeemText,
                            svgPath: AppImages.giftIcon,
                            isShowNavi: true,
                            appPages: AppPages.articleName,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    CheckInWidget(currentDay: currentDay),
                    const SizedBox(height: 24),

                    //progress
                    const ProgressCard(
                      daysRemain: 3,
                      exerciseTime: 250,
                      taskAmount: 10,
                      maxExerciseTime: 300,
                      maxTaskAmount: 10,
                      maxStepCount: 22000,
                      stepAmount: 18000,
                    ),
                    const SizedBox(height: 24),
                    const AchievementCard(),
                    const SizedBox(height: 24),

                    //chart
                    const ChartSectionWidget(),

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
                        context.goNamed(AppPages.logHistoryName);
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
                return const Center(child: Text('No data available.'));
              }
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
