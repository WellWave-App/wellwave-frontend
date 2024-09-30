import 'package:flutter/material.dart';
import 'package:wellwave_frontend/common/widget/app_bar.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/mission/data/mockup_data.dart';
import 'package:wellwave_frontend/features/mission/presentation/widgets/task_list.dart';

class QuestPage extends StatelessWidget {
  const QuestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> tasks = mockTasks;

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
          // Background Container
          Container(
            decoration: const BoxDecoration(
              color: AppColors.pinkColor,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(100),
              ),
            ),
            height: MediaQuery.of(context).size.height * 0.15,
          ),
          // Main Content
          Padding(
            padding: const EdgeInsets.only(top: 0.0), // Adjust as necessary
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: tasks.isNotEmpty ? tasks.length : 1,
                    itemBuilder: (context, index) {
                      if (tasks.isEmpty) {
                        return Center(child: Text('No tasks available'));
                      }
                      final task = tasks[index];
                      return TaskList(
                        imagePath: task['imagePath'],
                        taskId: task['taskId'],
                        taskName: task['taskName'],
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
