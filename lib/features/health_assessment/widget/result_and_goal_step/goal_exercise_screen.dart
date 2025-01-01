import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/features/health_assessment/presentation/bloc/lib/features/health_assessment/presentation/health_assessment_page/health_assessment_page_bloc.dart';
import 'package:wellwave_frontend/features/health_assessment/presentation/bloc/lib/features/health_assessment/presentation/health_assessment_page/health_assessment_page_state.dart';

class GoalExerciseScreen extends StatelessWidget {
  const GoalExerciseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HealthAssessmentPageBloc, HealthAssessmentPageState>(
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              Text(
                "กำหนดเป้าหมายเวลาออกกำลังกายต่อสัปดาห์",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: AppColors.blackColor),
              ),
              const SizedBox(height: 72),
            ],
          ),
        );
      },
    );
  }
}
