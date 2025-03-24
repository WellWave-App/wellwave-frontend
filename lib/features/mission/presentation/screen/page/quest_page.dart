import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellwave_frontend/common/widget/app_bar.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/mission/presentation/bloc/mission_bloc.dart';
import 'package:wellwave_frontend/features/mission/presentation/widgets/task_list.dart';

class QuestPage extends StatelessWidget {
  const QuestPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<MissionBloc>().add(LoadHabitsEvent());

    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        title: AppStrings.questText,
        backgroundColor: AppColors.pinkColor,
        titleColor: AppColors.whiteColor,
        textColor: AppColors.whiteColor,
        onLeading: true,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: AppColors.pinkColor,
            ),
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: Column(
              children: [
                Expanded(
                  child: BlocBuilder<MissionBloc, MissionState>(
                    builder: (context, state) {
                      if (state is HabitLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state is HabitLoaded) {
                        final habits = state.habits.habits;
                        if (habits.isEmpty) {
                          return const Center(
                            child: Text('No quests available'),
                          );
                        }

                        return ListView.builder(
                          itemCount: habits.length,
                          itemBuilder: (context, index) {
                            final habit = habits[index];
                            return TaskList(
                              imagePath: habit.thumbnailUrl,
                              taskId: habit.hid,
                              taskName: habit.title,
                              gemReward: habit.gemReward,
                            );
                          },
                        );
                      }

                      return const Center(
                        child: Text('Failed to load quests'),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
