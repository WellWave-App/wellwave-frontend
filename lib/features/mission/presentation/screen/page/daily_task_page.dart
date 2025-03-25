import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wellwave_frontend/common/widget/app_bar.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/mission/presentation/bloc/mission_bloc.dart';
import 'package:wellwave_frontend/features/mission/presentation/widgets/success_dialog.dart';
import '../../widgets/daily_task_list.dart';

class DailyTaskPage extends StatelessWidget {
  const DailyTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<MissionBloc>().add(LoadDailyTasksEvent());

    return BlocBuilder<MissionBloc, MissionState>(
      builder: (context, state) {
        if (state is DailyTaskLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is DailyTaskLoaded) {
          final tasks = state.dailyTasks.habits;
          final bool allTasksCompleted =
              tasks.every((task) => task.isActive == true);

          return Scaffold(
            appBar: CustomAppBar(
              context: context,
              title: AppStrings.dailyTaskText,
              backgroundColor: AppColors.secondaryDarkColor,
              titleColor: AppColors.whiteColor,
              textColor: AppColors.whiteColor,
              onLeading: true,
            ),
            body: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: AppColors.secondaryDarkColor,
                  ),
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Column(
                  children: [
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.taskCompletedWithGemText,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.whiteColor,
                                  ),
                        ),
                        SvgPicture.asset(
                          AppImages.gemIcon,
                          width: 24,
                          height: 24,
                        ),
                        Text(
                          ' x15',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.whiteColor,
                                  ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          height: 28,
                          decoration: BoxDecoration(
                            color: allTasksCompleted
                                ? AppColors.purpleGemColor
                                : AppColors.primaryColor,
                            border: Border.all(
                              color: AppColors.whiteColor,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                offset: const Offset(0, 2),
                                blurRadius: 0,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: allTasksCompleted
                                ? () {
                                    showDialog(
                                      context: context,
                                      builder: (_) => SuccessDialog(
                                        reward: 15,
                                        iconPath:
                                            SvgPicture.asset(AppImages.gemIcon),
                                      ),
                                    );
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                            ),
                            child: Text(
                              AppStrings.collectRewards,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(color: AppColors.whiteColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          final task = tasks[index];
                          return DailyTaskList(
                            imagePath: task.thumbnailUrl ?? '',
                            taskId: task.hid,
                            taskName: task.title,
                            exp: task.expReward,
                            isCompleted: task.isActive,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }

        if (state is DailyTaskError) {
          return Center(child: Text(state.message));
        }

        return const Center(child: Text('No daily tasks available'));
      },
    );
  }
}
