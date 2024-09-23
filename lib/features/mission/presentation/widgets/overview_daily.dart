import 'package:flutter/material.dart';
import 'package:wellwave_frontend/features/mission/presentation/widgets/tasklist_view.dart';

class OverviewDaily extends StatelessWidget {
  const OverviewDaily({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: 4, 
          itemBuilder: (context, index) {
            return const TaskListView();
          }),
    );
  }
}
