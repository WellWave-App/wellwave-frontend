import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellwave_frontend/common/widget/button_widget.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/mission/presentation/bloc/mission_bloc.dart';

class TaskGoalBottomSheet extends StatelessWidget {
  const TaskGoalBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<MissionBloc>().add(ResetGoalEvent());

    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        children: [
          Container(
            height: 5,
            width: 140,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.only(bottom: 8),
          ),
          const SizedBox(height: 24),
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.setGoalText,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  AppStrings.tellGoalText,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(right: 22.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                decoration: BoxDecoration(
                  color: AppColors.secondaryDarkColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  AppStrings.suggestText,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.whiteColor,
                      ),
                ),
              ),
            ),
          ),
          _buildCounterRow(
            label: AppStrings.setDayText,
            onDecrease: () =>
                context.read<MissionBloc>().add(DecrementDailyCountEvent()),
            onIncrease: () =>
                context.read<MissionBloc>().add(IncrementDailyCountEvent()),
            countSelector: (state) {
              if (state is HabitChallengeState) {
                return state.dailyCount;
              }
              return 1;
            },
          ),
          const SizedBox(height: 12),
          const Divider(color: Colors.grey),
          Padding(
            padding: const EdgeInsets.only(right: 22.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                decoration: BoxDecoration(
                  color: AppColors.secondaryDarkColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  AppStrings.suggestText,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.whiteColor,
                      ),
                ),
              ),
            ),
          ),
          _buildCounterRow(
            label: AppStrings.setTimeText,
            onDecrease: () =>
                context.read<MissionBloc>().add(DecrementMinuteCountEvent()),
            onIncrease: () =>
                context.read<MissionBloc>().add(IncrementMinuteCountEvent()),
            countSelector: (state) {
              if (state is HabitChallengeState) {
                return state.minuteCount;
              }
              return 5;
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: NextButton(
              text: AppStrings.confirmText,
              onPressed: () {
                final state = context.read<MissionBloc>().state;
                if (state is HabitChallengeState) {
                  context.read<MissionBloc>().add(ConfirmGoalEvent(
                        dailyCount: state.dailyCount,
                        minuteCount: state.minuteCount,
                      ));
                  Navigator.of(context).pop();
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCounterRow({
    required String label,
    required VoidCallback onDecrease,
    required VoidCallback onIncrease,
    required int Function(MissionState) countSelector,
  }) {
    return BlocBuilder<MissionBloc, MissionState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: Theme.of(context).textTheme.headlineMedium),
            Row(
              children: [
                IconButton(
                  onPressed: onDecrease,
                  icon: const Icon(Icons.remove),
                  iconSize: 24,
                ),
                Text(
                  '${countSelector(state)}',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                IconButton(
                  onPressed: onIncrease,
                  icon: const Icon(Icons.add),
                  iconSize: 24,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}


//  showModalBottomSheet(
//                       context: context,
//                       isScrollControlled: true,
//                       barrierColor: Colors.black.withOpacity(0.3),
//                       builder: (BuildContext context) {
//                         return const TaskGoalBottomSheet();
//                       },
//                     );