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
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12.0, left: 4),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(AppImages.expImage),
                          Text(
                              ' x${mockTasks.firstWhere((task) => task['taskId'] == taskId)['exp']}',
                              style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                      ElevatedButton(
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
                    ],
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
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(); 
                    },
                    child: SvgPicture.asset(AppImages.closeBTIcon),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                taskName,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          content: SizedBox(
            width: 300,
            height: MediaQuery.of(context).size.height * 0.15,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: Row(
                      children: [
                        Text(
                          AppStrings.prizesToBeReceivedText,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
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
                _showSuccessDialog(context);
                context.read<MissionBloc>().add(CompleteTaskEvent(taskId));
                return null;
              },
              elevation: 24,
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        bool isDialogClosed = false;

        Future.delayed(const Duration(seconds: 3), () {
          if (!isDialogClosed) {
            Navigator.of(context).pop();
            context.read<MissionBloc>().add(CompleteTaskEvent(taskId));
            isDialogClosed = true;
          }
        });

        return Dialog(
          backgroundColor: Colors.transparent,
          child: Center(
            child: Container(
              width: 300,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.all(30.0),
                            child: const Padding(
                              padding: EdgeInsets.only(top: 36.0),
                              child: Column(
                                children: [
                                  Text(
                                    AppStrings.youReceivedText,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.monetization_on,
                                        color: Colors.amber,
                                        size: 30,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'x15',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 36.0),
                            child: GestureDetector(
                              onTap: () {
                                if (!isDialogClosed) {
                                  Navigator.of(context).pop();

                                  isDialogClosed = true;
                                  context
                                      .read<MissionBloc>()
                                      .add(CompleteTaskEvent(taskId));
                                }
                              },
                              child: const Text(
                                AppStrings.closeWindowText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Image.asset(AppImages.barSuccessImage),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
