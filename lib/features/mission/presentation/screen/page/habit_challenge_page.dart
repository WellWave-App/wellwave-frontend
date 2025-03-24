import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellwave_frontend/common/widget/app_bar.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/mission/presentation/bloc/mission_bloc.dart';
import '../../widgets/task_list.dart';

class HabitChallengePage extends StatelessWidget {
  const HabitChallengePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Load recommended habits initially
    context.read<MissionBloc>().add(LoadRecHabitsEvent());

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
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Column(
              children: [
                TabBar(
                  isScrollable: true,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 10),
                  padding: const EdgeInsets.only(left: 10),
                  dividerColor: Colors.transparent,
                  labelColor: AppColors.whiteColor,
                  unselectedLabelColor: AppColors.mintTabTextGrayColor,
                  indicatorColor: AppColors.whiteColor,
                  labelStyle: Theme.of(context).textTheme.titleSmall,
                  onTap: (index) {
                    if (index == 0) {
                      context.read<MissionBloc>().add(LoadRecHabitsEvent());
                    } else {
                      String? category;
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
                      }
                      context
                          .read<MissionBloc>()
                          .add(LoadHabitsEvent(category: category));
                    }
                  },
                  tabs: const [
                    Tab(text: AppStrings.suggestText),
                    Tab(text: AppStrings.eatingText),
                    Tab(text: AppStrings.exerciseText),
                    Tab(text: AppStrings.sleepText),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      BlocBuilder<MissionBloc, MissionState>(
                        builder: (context, state) {
                          if (state is HabitLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (state is HabitLoaded && state.recHabits != null) {
                            final recommendations =
                                state.recHabits!.recommendations;
                            return ListView.builder(
                              itemCount: recommendations.length,
                              itemBuilder: (context, index) {
                                final habit = recommendations[index].habit;
                                return TaskList(
                                  imagePath: habit.thumbnailUrl,
                                  taskId: habit.hid,
                                  taskName: habit.title,
                                  expReward: habit.expReward,
                                );
                              },
                            );
                          }
                          return const Center(
                              child: Text('No recommended habits available'));
                        },
                      ),

                      // Other tabs remain the same...
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
                                );
                              },
                            );
                          }
                          return const Center(
                              child: Text('No habits available'));
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
                                );
                              },
                            );
                          }
                          return const Center(
                              child: Text('No habits available'));
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
                                );
                              },
                            );
                          }
                          return const Center(
                              child: Text('No habits available'));
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
