import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:wellwave_frontend/common/widget/app_bar.dart';
import 'package:wellwave_frontend/common/widget/custom_button.dart';
import 'package:wellwave_frontend/common/widget/custom_text_form_field.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'dart:io';

import 'package:wellwave_frontend/features/health_assessment/presentation/bloc/health_assessment_bloc.dart';
import 'package:wellwave_frontend/features/health_assessment/presentation/bloc/health_assessment_event.dart';
import 'package:wellwave_frontend/features/health_assessment/presentation/bloc/health_assessment_state.dart';
import 'package:wellwave_frontend/features/health_assessment/widget/step/add_pic_username_step.dart';
import 'package:wellwave_frontend/features/health_assessment/widget/step/family_history_step.dart';
import 'package:wellwave_frontend/features/health_assessment/widget/step/alcohol_step.dart';
import 'package:wellwave_frontend/features/health_assessment/widget/step/health_info_step.dart';
import 'package:wellwave_frontend/features/health_assessment/widget/step/personal_info_step.dart';
import 'package:wellwave_frontend/features/health_assessment/widget/step/start_health_step.dart';

class AssessmentScreen extends StatelessWidget {
  const AssessmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AssessmentBloc(),
      child: AssessmentScreenView(),
    );
  }
}

class AssessmentScreenView extends StatelessWidget {
  const AssessmentScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        onLeading: true,
        textColor: Colors.black,
        backgroundColor: Colors.transparent,
        onBackPressed: () => context.read<AssessmentBloc>().add(StepBack()),
      ),
      body: BlocBuilder<AssessmentBloc, AssessmentState>(
        builder: (context, state) {
          return Column(
            children: [
              StepProgressIndicator(
                totalSteps: 7,
                currentStep: state.currentStep + 1,
                size: 4,
                selectedColor: AppColors.primaryColor,
                unselectedColor: AppColors.lightgrayColor,
              ),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: StepContent(
                    currentStep: state.currentStep,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: CustomButton(
                  width: 250,
                  onPressed: () {
                    if (state.currentStep == 2) {
                      if ((_formKey.currentState?.validate() ?? false) &&
                          state.formData['gender'] != null) {
                        context.read<AssessmentBloc>().add(StepContinue());
                      } else {
                        context.read<AssessmentBloc>().add(ValidateGender());
                      }
                    } else {
                      if (_formKey.currentState?.validate() ?? false) {
                        context.read<AssessmentBloc>().add(StepContinue());
                      }
                    }
                  },
                  title: state.currentStep == 0
                      ? 'เข้าสู่แบบประเมิน'
                      : state.currentStep == 6
                          ? 'เสร็จสิ้น'
                          : 'ถัดไป',
                ),
              ),
            ],
          );
        },
      ),
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
      padding: const EdgeInsets.all(20.0),
      child: () {
        switch (currentStep) {
          case 0:
            return StartHealthStep();
          case 1:
            return AddPicUsernameStep(state: state);
          case 2:
            return PersonalInfoStep();
          case 3:
            return HealthInfoStep();
          case 4:
            return FamilyHistoryStep();
          case 5:
            return AlcoholStep();
          case 6:
            return Center(child: Text('Result'));
          default:
            return Center(child: Text('Unknown Step'));
        }
      }(),
    );
  }
}
