import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/mission/presentation/bloc/mission_bloc.dart';
import 'package:wellwave_frontend/features/mission/data/mockup_data.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';

class SuccessDialog extends StatelessWidget {
  final int taskId;

  const SuccessDialog({Key? key, required this.taskId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                        child: Padding(
                          padding: const EdgeInsets.only(top: 36.0),
                          child: Column(
                            children: [
                              const Text(
                                AppStrings.youReceivedText,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.monetization_on,
                                    color: Colors.amber,
                                    size: 30,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    ' x${mockTasks.firstWhere((task) => task['taskId'] == taskId)['exp']}',
                                    style: const TextStyle(
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
  }
}
