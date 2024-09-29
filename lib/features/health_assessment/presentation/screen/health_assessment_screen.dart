import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:wellwave_frontend/common/widget/app_bar.dart';
import 'package:wellwave_frontend/common/widget/custom_button.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/features/health_assessment/data/models/health_assessment_health_data_request_model.dart';
import 'package:wellwave_frontend/features/health_assessment/data/repositories/health_assessment_repository.dart';
import 'package:wellwave_frontend/features/health_assessment/presentation/bloc/lib/features/health_assessment/presentation/health_assessment_page/health_assessment_page_bloc.dart';
import 'package:wellwave_frontend/features/health_assessment/presentation/bloc/lib/features/health_assessment/presentation/health_assessment_page/health_assessment_page_event.dart';
import 'package:wellwave_frontend/features/health_assessment/presentation/bloc/lib/features/health_assessment/presentation/health_assessment_page/health_assessment_page_state.dart';
import 'package:wellwave_frontend/features/health_assessment/widget/result_assessment.dart';
import 'package:wellwave_frontend/features/health_assessment/widget/step/add_pic_username_step.dart';
import 'package:wellwave_frontend/features/health_assessment/widget/step/family_history_step.dart';
import 'package:wellwave_frontend/features/health_assessment/widget/step/alcohol_step.dart';
import 'package:wellwave_frontend/features/health_assessment/widget/step/goal_step.dart';
import 'package:wellwave_frontend/features/health_assessment/widget/step/health_info_step.dart';
import 'package:wellwave_frontend/features/health_assessment/widget/step/personal_info_step.dart';
import 'package:wellwave_frontend/features/health_assessment/widget/step/smoke_step.dart';
import 'package:wellwave_frontend/features/health_assessment/widget/start_health_step.dart';

class AssessmentScreen extends StatelessWidget {
  const AssessmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AssessmentBloc(),
      child: const AssessmentScreenStart(),
    );
  }
}

class AssessmentScreenStart extends StatelessWidget {
  const AssessmentScreenStart({super.key});

  @override
  Widget build(BuildContext context) {
    return const StartHealthStep();
  }
}

class AssessmentScreenView extends StatelessWidget {
  const AssessmentScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return BlocBuilder<AssessmentBloc, HealthAssessmentState>(
      builder: (context, state) {
        if (state.isCompleted) {
          return const ResultAssessment();
        }

        return Scaffold(
          appBar: state.isCompleted
              ? null
              : CustomAppBarWithStep(
                  context: context,
                  onLeading: true,
                  totalSteps: 8,
                  currentStep: state.currentStep,
                  textColor: AppColors.blackColor,
                  onBackPressed: () =>
                      context.read<AssessmentBloc>().add(StepBack()),
                ),
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.healthassessmentBG),
                fit: BoxFit.cover,
              ),
            ),
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
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: !((state.currentStep == 3 &&
                              state.famhisChoose.isEmpty) ||
                          (state.currentStep == 4 &&
                              state.alcoholChoose == null) ||
                          (state.currentStep == 5 &&
                              state.smokeChoose == null) ||
                          (state.currentStep == 6 && state.goalChoose == null))
                      ? CustomButton(
                          width: 250,
                          bgColor: AppColors.primaryColor,
                          textColor: AppColors.whiteColor,
                          onPressed: () {
                            if (state.currentStep == 0) {
                              if (formKey.currentState!.validate()) {
                                context
                                    .read<AssessmentBloc>()
                                    .add(StepContinue());
                              }
                            } else if (state.currentStep == 1) {
                              context
                                  .read<AssessmentBloc>()
                                  .add(ValidateGender());
                              if (formKey.currentState!.validate() &&
                                  !state.genderError) {
                                context
                                    .read<AssessmentBloc>()
                                    .add(StepContinue());
                              }
                            } else if (state.currentStep == 3) {
                              if (state.famhisChoose.isNotEmpty) {
                                context
                                    .read<AssessmentBloc>()
                                    .add(StepContinue());
                              }
                            } else if (state.currentStep == 4) {
                              if (state.alcoholChoose != null) {
                                context
                                    .read<AssessmentBloc>()
                                    .add(StepContinue());
                              }
                            } else if (state.currentStep == 5) {
                              if (state.smokeChoose != null) {
                                context
                                    .read<AssessmentBloc>()
                                    .add(StepContinue());
                              }
                            } else if (state.currentStep == 6) {
                              if (state.goalChoose != null) {
                                context
                                    .read<AssessmentBloc>()
                                    .add(StepContinue());
                              }
                            } else {
                              context
                                  .read<AssessmentBloc>()
                                  .add(StepContinue());
                            }
                          },
                          title: state.currentStep == 6 ? 'เสร็จสิ้น' : 'ถัดไป',
                        )
                      : Container(),
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
    final state = context.watch<AssessmentBloc>().state;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: () {
        switch (currentStep) {
          case 0:
            return AddPicUsernameStep(state: state);
          case 1:
            return const PersonalInfoStep();
          case 2:
            return const HealthInfoStep();
          case 3:
            return const FamilyHistoryStep();
          case 4:
            return const AlcoholStep();
          case 5:
            return const SmokeStep();
          case 6:
            return const GoalStep();
          default:
            return const Center(child: Text('Unknown Step'));
        }
      }(),
    );
  }
}
