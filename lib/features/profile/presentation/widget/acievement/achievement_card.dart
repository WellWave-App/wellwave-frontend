import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';

import '../../../../../config/constants/app_images.dart';
import '../../../../../config/constants/app_pages.dart';
import '../../bloc/archeivement_bloc/archeivement_bloc.dart';
import '../../bloc/archeivement_bloc/archeivement_event.dart';
import '../../bloc/archeivement_bloc/archeivement_state.dart';

class AchievementCard extends StatelessWidget {
  const AchievementCard({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ArcheivementBloc>().add(FetchArcheivement());
    });

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.whiteColor,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppStrings.archeivementText,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.goNamed(AppPages.achievementName);
                      },
                      child: Text(
                        AppStrings.seeAllText,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.greyColor,
                            ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                BlocBuilder<ArcheivementBloc, ArcheivementState>(
                  builder: (context, state) {
                    if (state is ArcheivementError) {
                      return Center(child: Text(state.message));
                    }

                    if (state is ArcheivementLoaded ||
                        state is ArcheivementReadSuccess) {
                      final achievements = (state is ArcheivementLoaded)
                          ? state.achievements
                          : (state as ArcheivementReadSuccess).achievements;

                      return Align(
                        alignment: Alignment
                            .centerLeft, // Ensures content starts at the left
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment
                                .start, // Aligns items at the top
                            children: (achievements.toList()
                                  ..sort((a, b) => a.isRead ? 1 : -1))
                                .map((achievement) {
                              final selectedLevel = achievement
                                  .achievement.levels
                                  .firstWhere((level) =>
                                      level.level == achievement.level);
                              final levelIcon =
                                  "http://10.0.2.2:3000${selectedLevel.iconUrl}";

                              return Padding(
                                padding: const EdgeInsets.only(right: 24.0),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Image.network(
                                      levelIcon,
                                      height: 64,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return SvgPicture.asset(
                                          AppImages.medalSvg,
                                          height: 64,
                                        );
                                      },
                                    ),
                                    if (!achievement.isRead)
                                      Positioned(
                                        top: -2,
                                        right: -2,
                                        child: Container(
                                          width: 8,
                                          height: 8,
                                          decoration: const BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
