import 'package:flutter/material.dart';
import 'package:wellwave_frontend/common/widget/app_bar.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';

import '../../../data/mockup_data.dart';
import '../../widgets/daily_task_list.dart';
import '../../widgets/task_list.dart';

class HabitChallengePage extends StatelessWidget {
  final List<Map<String, dynamic>> tasks = mockTasks;

  HabitChallengePage({super.key});

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
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(100),
                ),
              ),
              height: MediaQuery.of(context).size.height * 0.18,
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
                      Center(
                        child: ListView.builder(
                          itemCount: tasks.length,
                          itemBuilder: (context, index) {
                            final task = tasks[index];
                            return TaskList(
                              imagePath: task['imagePath'],
                              taskId: task['taskId'],
                              taskName: task['taskName'],
                            );
                          },
                        ),
                      ),
                      Center(
                        child: ListView.builder(
                          itemCount: tasks.length,
                          itemBuilder: (context, index) {
                            final task = tasks[index];
                            return TaskList(
                              imagePath: task['imagePath'],
                              taskId: task['taskId'],
                              taskName: task['taskName'],
                            );
                          },
                        ),
                      ),
                      Center(  child: ListView.builder(
                          itemCount: tasks.length,
                          itemBuilder: (context, index) {
                            final task = tasks[index];
                            return TaskList(
                              imagePath: task['imagePath'],
                              taskId: task['taskId'],
                              taskName: task['taskName'],
                            );
                          },
                        ),),
                      Center(  child: ListView.builder(
                          itemCount: tasks.length,
                          itemBuilder: (context, index) {
                            final task = tasks[index];
                            return TaskList(
                              imagePath: task['imagePath'],
                              taskId: task['taskId'],
                              taskName: task['taskName'],
                            );
                          },
                        ),),
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
