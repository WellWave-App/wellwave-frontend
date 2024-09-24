import 'package:flutter/material.dart';
import 'package:wellwave_frontend/features/mission/presentation/widgets/task_list_view.dart';

class OverviewHabitChallenge extends StatelessWidget {
  const OverviewHabitChallenge({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
            child: TaskListView(),
          );
        });
  }
}
