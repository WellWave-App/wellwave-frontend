import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellwave_frontend/features/mission/presentation/bloc/mission_bloc.dart';

import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/app_images.dart';
import '../../../../config/constants/app_strings.dart';
import '../../data/mockup_data.dart';
import 'mission_dialog.dart';
import 'task_goal_bottom_sheet.dart';

class TaskList extends StatelessWidget {
  final String imagePath;
  final int taskId;
  final String taskName;
  const TaskList(
      {super.key,
      required this.imagePath,
      required this.taskId,
      required this.taskName});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MissionBloc, MissionState>(
      builder: (context, state) {
        final isTaskCompleted =
            state is DailyTaskState && state.completedTaskIds.contains(taskId);

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.15,
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
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  // First Column for Image
                  Expanded(
                    flex: 1,
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover, // Adjust the image size
                    ),
                  ),
                  // Second Column for Task Name and Experience
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                taskName,
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                                maxLines: 2, // Set the maximum number of lines
                                overflow:
                                    TextOverflow.visible, // Prevent overflow
                              ),
                            ),
                            SizedBox(
                              width: 80,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Image.asset(AppImages.expImage),
                                    Text(
                                      ' x${mockTasks.firstWhere((task) => task['taskId'] == taskId)['exp']}',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              height: 28,
                              width: 210,
                              child: ElevatedButton(
                                onPressed: isTaskCompleted
                                    ? null
                                    : () {
                                        showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          barrierColor:
                                              Colors.black.withOpacity(0.3),
                                          builder: (BuildContext context) {
                                            return const TaskGoalBottomSheet();
                                          },
                                        );
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// child: Row(
//   children: [
//     // คอลัมน์แรก: กำหนดขนาดเป็น 1/3 ของแถว
//     Expanded(
//       flex: 1, // flex = 1 ให้สัดส่วนเท่ากันกับคอลัมน์อื่น
//       child: Column(
//         children: [
//           // เนื้อหาของคอลัมน์แรก
//           Image.asset(imagePath),
//         ],
//       ),
//     ),

//     // คอลัมน์ที่สอง: กำหนดขนาดเป็น 1/3 ของแถว
//     Expanded(
//       flex: ,
//       child: Column(
//         children: [
//           // เนื้อหาของคอลัมน์ที่สอง
//           Text(
//             taskName,
//             style: Theme.of(context).textTheme.headlineSmall,
//           ),
//         ],
//       ),
//     ),

//     // คอลัมน์ที่สาม: กำหนดขนาดเป็น 1/3 ของแถว
//     Expanded(
//       flex: 1,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           // เนื้อหาของคอลัมน์ที่สาม
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Image.asset(AppImages.expImage),
//               Text(
//                 ' x${mockTasks.firstWhere((task) => task['taskId'] == taskId)['exp']}',
//                 style: Theme.of(context).textTheme.bodySmall,
//               ),
//             ],
//           ),
//         ],
//       ),
//     ),
//   ],
// ),
// child: Row(
//   children: [
//     Image.asset(imagePath),
//     Text(
//       taskName,
//       style: Theme.of(context).textTheme.headlineSmall,
//     ),
//     Image.asset(AppImages.expImage),
//     Text(
//       ' x${mockTasks.firstWhere((task) => task['taskId'] == taskId)['exp']}',
//       style: Theme.of(context).textTheme.bodySmall,
//     ),
//   ],
// ),
// child: Row(
//   children: [
//     Row(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(5.0),
//           child: Container(
//             width: 100,
//             height: 100,
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage(imagePath),
//               ),
//             ),
//           ),
//         ),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 taskName,
//                 style: Theme.of(context).textTheme.headlineSmall,
//                 // // maxLines: 2,
//                 // overflow: TextOverflow.ellipsis,
//                 // softWrap: true,
//               ),
//             ],
//           ),
//         ),
//         Column(
//           children: [
//             Image.asset(AppImages.expImage),
//             Text(
//               ' x${mockTasks.firstWhere((task) => task['taskId'] == taskId)['exp']}',
//               style: Theme.of(context).textTheme.bodySmall,
//             ),
//           ],
//         ),
//       ],
//     ),
//   ],
// ),

//  Container(
//                   color: Colors.black87,
//                   child: ElevatedButton(
//                     onPressed: isTaskCompleted
//                         ? null
//                         : () {
//                             showDialog(
//                               context: context,
//                               builder: (_) => MissionDialog(
//                                 taskName: taskName,
//                                 taskId: taskId,
//                               ),
//                             );
//                           },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: isTaskCompleted
//                           ? Colors.grey
//                           : AppColors.primaryColor,
//                       foregroundColor: AppColors.whiteColor,
//                       minimumSize: const Size(64, 28),
//                       side: const BorderSide(
//                         color: AppColors.whiteColor,
//                         width: 2.0,
//                       ),
//                       elevation: 2,
//                       shadowColor: AppColors.darkGrayColor,
//                     ),
//                     child: Text(
//                       AppStrings.startText,
//                       textAlign: TextAlign.center,
//                       style: Theme.of(context)
//                           .textTheme
//                           .titleSmall
//                           ?.copyWith(color: AppColors.whiteColor),
//                     ),
//                   ),
//                 ),
