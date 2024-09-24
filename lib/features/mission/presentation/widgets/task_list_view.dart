import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/mission/presentation/bloc/mission_bloc.dart';
import 'task_goal_selector .dart';

class TaskListView extends StatelessWidget {
  final String? imagePath;

  const TaskListView({super.key, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.baseGrayColor,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(8.0),
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
                const SizedBox(height: 4),
                const Row(
                  children: [
                    Icon(Icons.check_box_outline_blank),
                    SizedBox(width: 8),
                    Text('x 10'),
                    SizedBox(width: 8),
                  ],
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.only(right: 24.0),
                  child: BlocProvider(
                    create: (context) => MissionBloc(),
                    child: BlocBuilder<MissionBloc, MissionState>(
                      builder: (context, state) {
                        if (state is TaskInProgressState) {
                          return ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: const TaskGoalSelector(),
                                  );
                                },
                              );
                            },
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    AppStrings.taskInProgressText,
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else if (state is TaskCompletedState) {
                          return ElevatedButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled:
                                    false, 
                                builder: (BuildContext context) {
                                  return Container(
                                    padding: const EdgeInsets.all(16.0),
                                    child: const TaskGoalSelector(),
                                  );
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.mintColor,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    AppStrings.taskCompletedText,
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return ElevatedButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                barrierColor: Colors.black.withOpacity(0.3),
                                builder: (BuildContext context) {
                                  int dayCount = 1;
                                  int sessionCount = 1;
                                  return Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.5,
                                    width: MediaQuery.of(context).size.height *
                                        0.5,
                                    padding: const EdgeInsets.all(16.0),
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(
                                          255, 239, 231, 231),
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(16)),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 5, 
                                          width: 140, 
                                          decoration: BoxDecoration(
                                            color: AppColors
                                                .blackColor, 
                                            borderRadius: BorderRadius.circular(
                                                10), 
                                          ),
                                          margin: const EdgeInsets.only(
                                              bottom:
                                                  8), 
                                        ),
                                        const SizedBox(height: 48),
                                        const Text(
                                          'กำหนดเป้าหมายภารกิจ',
                                        ),
                                        const SizedBox(height: 8),
                                        const Text(
                                          'บอกให้เรารู้ถึงเป้าหมายของคุณ',
                                        ),
                                        const SizedBox(height: 24),
                                        const Text('data'),
                                        _buildCounterRow(
                                          label: 'เลือกจำนวนวัน',
                                          count: dayCount,
                                          onDecrease: () {
                                            if (sessionCount > 1) {
                                              dayCount--;
                                            }
                                          },
                                          onIncrease: () {
                                            dayCount++;
                                          },
                                        ),
                                        Container(
                                          height: 2, 
                                          
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: AppColors
                                                .baseGrayColor, 
                                            borderRadius: BorderRadius.circular(
                                                100), 
                                          ),
                                          margin: const EdgeInsets.only(
                                              bottom:
                                                  8), 
                                        ),
                                        const Text('data'),
                                        _buildCounterRow(
                                          label: 'เลือกจำนวนนาที/วัน',
                                          count: sessionCount,
                                          onDecrease: () {
                                            if (sessionCount > 1) {
                                              sessionCount--;
                                            }
                                          },
                                          onIncrease: () {
                                            sessionCount++;
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.mintColor,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    AppStrings.taskCompletedText,
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildCounterRow({
    required String label,
    required int count,
    required VoidCallback onDecrease,
    required VoidCallback onIncrease,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Row(
          children: [
            IconButton(
              onPressed: onDecrease,
              icon: const Icon(Icons.remove),
            ),
            Text('$count'),
            IconButton(
              onPressed: onIncrease,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }
}
