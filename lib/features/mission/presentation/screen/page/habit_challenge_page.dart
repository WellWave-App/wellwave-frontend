import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellwave_frontend/common/widget/app_bar.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/mission/presentation/bloc/mission_bloc.dart';
import '../../widgets/task_list.dart';

class HabitChallengePage extends StatefulWidget {
  const HabitChallengePage({super.key});

  @override
  State<HabitChallengePage> createState() => _HabitChallengePageState();
}

class _HabitChallengePageState extends State<HabitChallengePage> {
  String category = 'rec';

  @override
  void initState() {
    super.initState();

    context.read<MissionBloc>().add(LoadHabitsEvent(category: category));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: CustomAppBar(
          context: context,
          title: AppStrings.habitChallengeText,
          backgroundColor: AppColors.mintColor,
          titleColor: AppColors.whiteColor,
          textColor: AppColors.whiteColor,
          onLeading: true,
        ),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: AppColors.mintColor,
              ),
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            Column(
              children: [
                TabBar(
                  isScrollable: false,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 4),
                  padding: EdgeInsets.zero,
                  dividerColor: Colors.transparent,
                  labelColor: AppColors.whiteColor,
                  unselectedLabelColor: AppColors.mintTabTextGrayColor,
                  indicatorColor: AppColors.whiteColor,
                  labelStyle: Theme.of(context).textTheme.titleSmall,
                  onTap: (index) {
                    setState(() {
                      switch (index) {
                        case 1:
                          category = 'diet';
                          break;
                        case 2:
                          category = 'exercise';
                          break;
                        case 3:
                          category = 'sleep';
                          break;
                        default:
                          category = 'rec';
                          break;
                      }
                    });

                    context
                        .read<MissionBloc>()
                        .add(LoadHabitsEvent(category: category));
                    debugPrint('Loading habits for category: $category');
                  },
                  tabs: const [
                    Tab(text: AppStrings.suggestText),
                    Tab(text: AppStrings.eatingText),
                    Tab(text: AppStrings.exerciseText),
                    Tab(text: AppStrings.sleepText),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: TabBarView(
                    children: [
                      BlocBuilder<MissionBloc, MissionState>(
                        builder: (context, state) {
                          if (state is HabitLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (state is HabitLoaded) {
                            final habits = state.habits.habits;
                            return ListView.builder(
                              itemCount: habits.length,
                              itemBuilder: (context, index) {
                                final habit = habits[index];
                                return TaskList(
                                        imagePath: habit.thumbnailUrl,
                                        taskId: habit.hid,
                                        taskName: habit.title,
                                        expReward: habit.expReward,
                                        defaultDailyMinuteGoal:
                                            habit.defaultDailyMinuteGoal,
                                        defaultDaysGoal: habit.defaultDaysGoal,
                                        progressPercentage: habit.challengeInfo
                                                ?.percentageProgress
                                                .toDouble() ??
                                            0.0,
                                        isActive: habit.isActive)
                                    .also((_) {});
                              },
                            );
                          }
                          return Container();
                        },
                      ),
                      BlocBuilder<MissionBloc, MissionState>(
                        builder: (context, state) {
                          if (state is HabitLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (state is HabitLoaded) {
                            final habits = state.habits.habits;
                            return ListView.builder(
                              itemCount: habits.length,
                              itemBuilder: (context, index) {
                                final habit = habits[index];
                                return TaskList(
                                        imagePath: habit.thumbnailUrl,
                                        taskId: habit.hid,
                                        taskName: habit.title,
                                        expReward: habit.expReward,
                                        defaultDailyMinuteGoal:
                                            habit.defaultDailyMinuteGoal,
                                        defaultDaysGoal: habit.defaultDaysGoal,
                                        progressPercentage: habit.challengeInfo
                                                ?.percentageProgress
                                                .toDouble() ??
                                            0.0,
                                        isActive: habit.isActive)
                                    .also((_) {});
                              },
                            );
                          }
                          return Container();
                        },
                      ),
                      BlocBuilder<MissionBloc, MissionState>(
                        builder: (context, state) {
                          if (state is HabitLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (state is HabitLoaded) {
                            final habits = state.habits.habits;
                            return ListView.builder(
                              itemCount: habits.length,
                              itemBuilder: (context, index) {
                                final habit = habits[index];
                                return TaskList(
                                        imagePath: habit.thumbnailUrl,
                                        taskId: habit.hid,
                                        taskName: habit.title,
                                        expReward: habit.expReward,
                                        defaultDailyMinuteGoal:
                                            habit.defaultDailyMinuteGoal,
                                        defaultDaysGoal: habit.defaultDaysGoal,
                                        isActive: habit.isActive)
                                    .also((_) {});
                              },
                            );
                          }
                          return Container();
                        },
                      ),
                      BlocBuilder<MissionBloc, MissionState>(
                        builder: (context, state) {
                          if (state is HabitLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (state is HabitLoaded) {
                            final habits = state.habits.habits;
                            return ListView.builder(
                              itemCount: habits.length,
                              itemBuilder: (context, index) {
                                final habit = habits[index];
                                return TaskList(
                                    imagePath: habit.thumbnailUrl,
                                    taskId: habit.hid,
                                    taskName: habit.title,
                                    expReward: habit.expReward,
                                    defaultDailyMinuteGoal:
                                        habit.defaultDailyMinuteGoal,
                                    defaultDaysGoal: habit.defaultDaysGoal,
                                    isActive: habit.isActive);
                              },
                            );
                          }
                          return Container();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

extension ObjectExt<T> on T {
  T also(void Function(T) action) {
    action(this);
    return this;
  }
}
