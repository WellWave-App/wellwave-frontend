import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wellwave_frontend/common/widget/app_bar.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_pages.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:wellwave_frontend/features/profile/presentation/bloc/profile_event.dart';
import 'package:wellwave_frontend/features/profile/presentation/bloc/profile_state.dart';
import 'package:wellwave_frontend/features/profile/presentation/widget/acievement/achievement_card.dart';
import 'package:wellwave_frontend/features/profile/presentation/widget/profile/check_in_card.dart';
import 'package:wellwave_frontend/features/profile/presentation/widget/profile/progress_card.dart';
import 'package:wellwave_frontend/features/profile/presentation/widget/profile/progress_chart_card.dart';
import 'package:wellwave_frontend/features/profile/presentation/widget/profile/round_border_text.dart';
import 'package:wellwave_frontend/features/profile/presentation/widget/profile/user_info.dart';

import '../../../logs/presentation/logs_bloc/logs_bloc.dart';
import '../../../logs/presentation/widget/chart.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ProfileBloc>().add(FetchUserProfile(3));

    int leagueIndex = 2;
    int currentDay = 4;

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

    final today = DateTime.now();

    context.read<LogsBloc>().add(LogsFetchedGraph(today));
    debugPrint('Dispatched LogsFetchedGraph event');

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
                debugPrint('Loaded profile: ${profile.username}');
                
                return Column(
                  children: [
                    const SizedBox(height: 24),
                    UserInformation(
                      userID: 'UID${profile.uid}',
                      userName: profile.username,
                      gemAmount: profile.gem,
                      expAmount: profile.exp,
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
                          child: const RoundedText(
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
                    const ProgressCard(
                      daysRemain: 3,
                      exerciseTime: 250,
                      taskAmount: 10,
                      maxExerciseTime: 300,
                      maxTaskAmount: 10,
                    ),
                    const SizedBox(height: 24),
                    const AchievementCard(),
                    const SizedBox(height: 24),
                    BlocBuilder<LogsBloc, LogsState>(
                      builder: (context, state) {
                        double weight = 0.0;
                        double lastWeekWeight = 0.0;

                        if (state is LogsLoadGraphInProgress) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is LogsLoadGraphSuccess) {
                          if (state.logsWeightlist.isNotEmpty) {
                            weight = state.logsWeightlist.last?.value ?? 0.0;
                            lastWeekWeight = state.logsWeightlist.length > 1
                                ? state
                                    .logsWeightlist[
                                        state.logsWeightlist.length - 2]
                                    ?.value ??
                                    0.0
                                : 0.0;
                          }
                        }

                        return ProgressChartCard(
                          title: AppStrings.weightText,
                          value: weight,
                          unit: AppStrings.kgText,
                          lastWeekValue: lastWeekWeight,
                          chart: const LineChartSample2(
                            logType: AppStrings.weightLogText,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
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
                    const SizedBox(height: 24),
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
                    const SizedBox(height: 24),
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
}
