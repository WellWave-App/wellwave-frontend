import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/mission/presentation/bloc/daily_task_bloc.dart';

class TaskListView extends StatelessWidget {
  final String? imagePath;

  const TaskListView({super.key, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.baseGrayColor,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imagePath != null
                      ? AssetImage(imagePath!)
                      : const AssetImage(AppImages.emptyComponentImage),
                ),
              ),
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ชื่อภารกิจ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 12),
                const Row(
                  children: [
                    Icon(Icons.check_box_outline_blank),
                    SizedBox(width: 8),
                    Text('x 10'),
                    SizedBox(width: 8),
                  ],
                ),
                const SizedBox(height: 12),
                BlocProvider(
                    create: (context) => DailyTaskBloc(),
                    child: BlocBuilder<DailyTaskBloc, DailyTaskState>(
                        builder: (context, state) {
                      if (state is TaskInProgressState) {
                        return ElevatedButton(
                          onPressed: () {
                            context
                                .read<DailyTaskBloc>()
                                .add(CompleteTaskEvent());
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(32, 4, 32, 4),
                            child: Text(AppStrings.taskInProgressText,
                                style: Theme.of(context).textTheme.bodySmall),
                          ),
                        );
                      } else if (state is TaskCompletedState) {
                        return ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.mintColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(32, 4, 32, 4),
                            child: Text(AppStrings.taskCompletedText,
                                style: Theme.of(context).textTheme.bodySmall),
                          ),
                        );
                      }
                      return ElevatedButton(
                        onPressed: () {
                          context
                              .read<DailyTaskBloc>()
                              .add(CompleteTaskEvent());
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(32, 4, 32, 4),
                          child: Text(
                            AppStrings.taskInProgressText,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      );
                    }))
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
