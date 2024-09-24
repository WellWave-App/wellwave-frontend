import 'package:flutter/material.dart';
import 'package:wellwave_frontend/common/widget/app_bar.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import '../../widgets/task_list_view.dart';

class DailyTaskPage extends StatelessWidget {
  const DailyTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        title: AppStrings.dailyTaskText,
        backgroundColor: AppColors.backgroundColor,
        onLeading: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                    child: TaskListView(),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
