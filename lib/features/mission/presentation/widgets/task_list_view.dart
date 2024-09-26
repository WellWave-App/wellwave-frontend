import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/mission/presentation/bloc/mission_bloc.dart';
import 'package:wellwave_frontend/features/mission/presentation/widgets/mission_popup.dart';

class TaskListView extends StatelessWidget {
  final String? imagePath;

  const TaskListView({super.key, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
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
              child: Text('ชื่อภารกิจ',
                  style: Theme.of(context).textTheme.headlineSmall)),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(AppImages.expImage),
                    const Text(' x10'),
                  ],
                ),
              ),
              BlocBuilder<MissionBloc, MissionState>(
                builder: (context, state) {
                  
                  bool isButtonDisabled =
                      state is HabitChallengeState && state.dailyCount > 0;

                  return ElevatedButton(
                    onPressed: isButtonDisabled
                        ? null 
                        : () {
                            context.read<MissionBloc>().add(ConfirmGoalEvent(
                                dailyCount: 1,
                                minuteCount:
                                    5)); 
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return MissionPopup(
                                  missionName: 'Mission 1',
                                  completedDays: ['Day 1', 'Day 2'],
                                  reward: 15,
                                  receiveText: Text(
                                    AppStrings.prizesToBeReceivedText,
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                  ),
                                );
                              },
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
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
                  );
                },
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}
