import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';

import '../../../../common/widget/app_bar.dart';
import '../../../../config/constants/app_colors.dart';
import '../../data/models/archeivement_request_model.dart';
import '../bloc/archeivement_bloc/archeivement_bloc.dart';
import '../bloc/archeivement_bloc/archeivement_event.dart';
import '../bloc/archeivement_bloc/archeivement_state.dart';

class AchievementScreen extends StatelessWidget {
  const AchievementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ArcheivementBloc>()
        ..add(FetchArcheivement())
        ..add(FetchAllArcheivement());
    });

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(
        title: AppStrings.archeivementText,
        context: context,
        onLeading: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 36, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //  Record Section
              // Text(
              //   AppStrings.yourRecordText,
              //   style: Theme.of(context)
              //       .textTheme
              //       .headlineMedium
              //       ?.copyWith(fontWeight: FontWeight.bold),
              // ),
              // const SizedBox(height: 24),
              // SizedBox(
              //   height: 169, // Constrain the height of the horizontal scroll
              //   child: ListView(
              //     scrollDirection: Axis.horizontal,
              //     children: const [
              //       ArchievementRecordCard(
              //         svgPath: AppImages.medalSvg,
              //         archievementName: 'ยอดนักแข่ง EXP',
              //       ),
              //       ArchievementRecordCard(
              //         svgPath: AppImages.medalSvg,
              //         archievementName: 'ยอดนักแข่ง EXP',
              //       ),
              //       ArchievementRecordCard(
              //         svgPath: AppImages.medalSvg,
              //         archievementName: 'ยอดนักแข่ง EXP',
              //       ),
              //       ArchievementRecordCard(
              //         svgPath: AppImages.medalSvg,
              //         archievementName: 'ยอดนักแข่ง EXP',
              //       ),
              //     ],
              //   ),
              // ),
              // const SizedBox(height: 32),

              // Medals Section
              // Text(
              //   AppStrings.medalText,
              //   style: Theme.of(context)
              //       .textTheme
              //       .headlineMedium
              //       ?.copyWith(fontWeight: FontWeight.bold),
              // ),
              // const SizedBox(height: 24),
              BlocBuilder<ArcheivementBloc, ArcheivementState>(
                builder: (context, state) {
                  if (state is ArcheivementError) {
                    return Center(child: Text(state.message));
                  }

                  if (state is AllArcheivementLoaded) {
                    // Create a map of achievement ID to highest level earned
                    final earnedAchievementsMap = Map.fromEntries(state
                        .earnedAchievements
                        .map((e) => MapEntry(e.achId, e)));

                    // Separate earned and unearned achievements
                    final List<Widget> achievementWidgets = [];
                    final List<Widget> unearnedWidgets = [];

                    for (var achievement in state.allAchievements) {
                      final earnedAchievement =
                          earnedAchievementsMap[achievement.achId];

                      if (earnedAchievement != null) {
                        // Add earned achievements
                        final selectedLevel = earnedAchievement
                            .achievement.levels
                            .firstWhere((level) =>
                                level.level == earnedAchievement.level);
                        final levelIcon =
                            "http://10.0.2.2:3000${selectedLevel.iconUrl}";

                        achievementWidgets.add(
                          GestureDetector(
                            onTap: () => _showAchievementPopup(
                                context, earnedAchievement),
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Image.network(
                                  levelIcon,
                                  height: 128,
                                  errorBuilder: (context, error, stackTrace) {
                                    return SvgPicture.asset(
                                      AppImages.medalSvg,
                                      height: 128,
                                    );
                                  },
                                ),
                                if (!earnedAchievement.isRead)
                                  Positioned(
                                    top: -4,
                                    right: -4,
                                    child: Container(
                                      width: 16,
                                      height: 16,
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        // Add unearned achievements
                        final level1Icon = achievement.levels
                            .firstWhere((level) => level.level == 1)
                            .iconUrl;
                        final levelIcon = "http://10.0.2.2:3000$level1Icon";

                        unearnedWidgets.add(
                          ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              AppColors.blueGrayColor,
                              BlendMode.srcIn,
                            ),
                            child: Image.network(
                              levelIcon,
                              height: 128,
                              errorBuilder: (context, error, stackTrace) {
                                return SvgPicture.asset(
                                  AppImages.medalSvg,
                                  height: 128,
                                );
                              },
                            ),
                          ),
                        );
                      }
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22.5),
                      child: Wrap(
                        spacing: 45.0,
                        runSpacing: 16.0,
                        alignment: WrapAlignment.start,
                        children: [
                          ...achievementWidgets, // Earned achievements shown first
                          ...unearnedWidgets, // Unearned achievements shown last
                        ],
                      ),
                    );
                  }

                  return const Center(child: CircularProgressIndicator());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

void _showAchievementPopup(
    BuildContext context, ArcheivementRequestModel achievement) {
  final selectedLevel = achievement.achievement.levels
      .firstWhere((level) => level.level == achievement.level);
  final levelIcon = "http://10.0.2.2:3000${selectedLevel.iconUrl}";

  context.read<ArcheivementBloc>().add(ReadArcheivement(
      uid: achievement.uid,
      achId: achievement.achId,
      level: achievement.level));

  showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.5),
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(21),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFB2D6E7).withOpacity(1),
                      offset: const Offset(0, 6),
                      blurRadius: 0,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 48.0, horizontal: 16),
                  child: Column(
                    children: [
                      Image.network(
                        levelIcon,
                        height: 160,
                        errorBuilder: (context, error, stackTrace) {
                          return SvgPicture.asset(
                            AppImages.medalSvg,
                            height: 100,
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      Text(
                        achievement.achievement.title,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        achievement.achievement.description,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontSize: 11.0),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 34),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Text(
                  AppStrings.closeWindowText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.whiteColor,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.whiteColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
