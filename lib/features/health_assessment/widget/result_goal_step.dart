import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wellwave_frontend/common/widget/app_bar.dart';
import 'package:wellwave_frontend/common/widget/custom_button.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/features/health_assessment/data/repositories/health_assessment_repository.dart';
import 'package:wellwave_frontend/features/health_assessment/presentation/bloc/lib/features/health_assessment/presentation/health_assessment_page/health_assessment_page_bloc.dart';
import 'package:wellwave_frontend/features/health_assessment/presentation/bloc/lib/features/health_assessment/presentation/health_assessment_page/health_assessment_page_event.dart';
import 'package:wellwave_frontend/features/health_assessment/presentation/bloc/lib/features/health_assessment/presentation/health_assessment_page/health_assessment_page_state.dart';
import 'package:wellwave_frontend/features/health_assessment/widget/result_and_goal_step/congrats_screen.dart';
import 'package:wellwave_frontend/features/health_assessment/widget/result_and_goal_step/goal_exercise_screen.dart';
import 'package:wellwave_frontend/features/health_assessment/widget/result_and_goal_step/goal_step_screen.dart';
import 'package:wellwave_frontend/features/health_assessment/widget/result_and_goal_step/recommend_screen.dart';

class ResultTask extends StatelessWidget {
  const ResultTask({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HealthAssessmentPageBloc(HealthAssessmentRepository()),
      child: const ResultScreen(),
    );
  }
}

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return BlocBuilder<HealthAssessmentPageBloc, HealthAssessmentPageState>(
      builder: (context, state) {
        if (state.isResultCompleted) {
          return const CongratsScreen();
        }

        return Scaffold(
          appBar: state.isResultCompleted
              ? null
              : CustomAppBarWithStep(
                  context: context,
                  onLeading: (state.currentStep == 0 || state.currentStep == 3)
                      ? false
                      : true,
                  totalSteps: 5,
                  currentStep: state.currentStep,
                  textColor: AppColors.blackColor,
                  showStepIndicator: false,
                  onBackPressed: () =>
                      context.read<HealthAssessmentPageBloc>().add(StepBack()),
                ),
          body: Container(
            child: Column(
              children: [
                Expanded(
                  child: Form(
                    key: formKey,
                    child: StepContent(
                      currentStep: state.currentStep,
                    ),
                  ),
                ),
                if (state.currentStep != 3)
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: CustomButton(
                      width: 250,
                      bgColor: AppColors.primaryColor,
                      textColor: AppColors.whiteColor,
                      onPressed: () {
                        context
                            .read<HealthAssessmentPageBloc>()
                            .add(StepContinue());
                      },
                      title: state.currentStep == 2 ? 'เสร็จสิ้น' : 'ถัดไป',
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class StepContent extends StatelessWidget {
  final int currentStep;

  const StepContent({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HealthAssessmentPageBloc>().state;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: () {
        switch (currentStep) {
          case 0:
            return RecommendScreen();
          case 1:
            return GoalStepScreen();
          case 2:
            return GoalExerciseScreen();
          case 3:
            return CongratsScreen();

          default:
            return const Center(child: Text('Unknown Step'));
        }
      }(),
    );
  }
}
