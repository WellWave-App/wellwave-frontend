import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellwave_frontend/features/mission/presentation/bloc/mission_bloc.dart';

class TaskGoalSelector extends StatelessWidget {
  const TaskGoalSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MissionBloc(),
      child: BlocBuilder<MissionBloc, MissionState>(
        builder: (context, state) {
          int dayCount = 1;
          int sessionCount = 1;

          if (state is TaskCompletedState) {}

          return Column(
            // mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'กำหนดเป้าหมายภารกิจ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 8),
              const Text('บอกให้เรารู้ถึงเป้าหมายของคุณ'),
              const SizedBox(height: 16),
              // _buildCounterRow(
              //   label: 'เลือกจำนวนวัน',
              //   count: dayCount,
              //   onDecrease: () {
              //     if (dayCount > 1) {
              //       dayCount--;
              //     }
              //   },
              //   onIncrease: () {
              //     dayCount++;
              //   },
              // ),
              const SizedBox(height: 8),
              // _buildCounterRow(
              //   label: 'เลือกจำนวนครั้ง/วัน',
              //   count: sessionCount,
              //   onDecrease: () {
              //     if (sessionCount > 1) {
              //       sessionCount--;
              //     }
              //   },
              //   onIncrease: () {
              //     sessionCount++;
              //   },
              // ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  context.read<MissionBloc>().add(CompleteTaskEvent());
                },
                child: const Text('ยืนยัน'),
              ),
            ],
          );
        },
      ),
    );
  }

  // Widget _buildCounterRow({
  //   required String label,
  //   required int count,
  //   required VoidCallback onDecrease,
  //   required VoidCallback onIncrease,
  // }) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       Text(label),
  //       Row(
  //         children: [
  //           IconButton(
  //             onPressed: onDecrease,
  //             icon: const Icon(Icons.remove),
  //           ),
  //           Text('$count'),
  //           IconButton(
  //             onPressed: onIncrease,
  //             icon: const Icon(Icons.add),
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }
}
