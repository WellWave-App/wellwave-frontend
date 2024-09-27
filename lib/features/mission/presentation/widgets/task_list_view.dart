import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/mission/data/mockup_data.dart';
import 'package:wellwave_frontend/features/mission/presentation/bloc/mission_bloc.dart';

class TaskListView extends StatelessWidget {
  final String imagePath;
  final int taskId; 
  final String taskName; 

  const TaskListView({
    super.key,
    required this.imagePath,
    required this.taskId,
    required this.taskName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MissionBloc, MissionState>(
      builder: (context, state) {
        
        final isTaskCompleted =
            state is DailyTaskState && state.completedTaskIds.contains(taskId);

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.25),
                  spreadRadius: 0.5,
                  blurRadius: 4,
                ),
              ],
            ),
            padding: const EdgeInsets.all(2.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(imagePath),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        taskName,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Image.asset(AppImages.expImage),
                          const SizedBox(width: 5),
                          Text(
                            ' x${mockTasks.firstWhere((task) => task['taskId'] == taskId)['exp']}',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: ElevatedButton(
                    onPressed: isTaskCompleted
                        ? null
                        : () {
                            _showMissionDialog(context);
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isTaskCompleted
                          ? Colors.grey
                          : AppColors.primaryColor,
                      foregroundColor: AppColors.whiteColor,
                      minimumSize: const Size(64, 28),
                      side: const BorderSide(
                        color: AppColors.whiteColor,
                        width: 2.0,
                      ),
                      elevation: 2,
                      shadowColor: AppColors.darkGrayColor,
                    ),
                    child: Text(
                      AppStrings.startText,
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
          ),
        );
      },
    );
  }

  void _showMissionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            taskName,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          content: SizedBox(
            width: 300,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0, bottom: 48),
                    child: Row(
                      children: [
                        Image.asset(AppImages.expImage),
                        Text(
                          ' x${mockTasks.firstWhere((task) => task['taskId'] == taskId)['exp']}',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            SlideAction(
              outerColor: AppColors.secondaryDarkColor,
              text: AppStrings.slideForSuccessText,
              textStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppColors.whiteColor,
                  ),
              sliderButtonIcon: Row(
                children: [SvgPicture.asset(AppImages.arrowForwardIcon)],
              ),
              onSubmit: () {
                Navigator.of(context).pop();
                context
                    .read<MissionBloc>()
                    .add(CompleteTaskEvent(taskId)); 
                return null;
              },
              elevation: 24,
            ),
          ],
        );
      },
    );
  }
}
