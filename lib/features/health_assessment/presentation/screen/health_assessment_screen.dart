import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:wellwave_frontend/common/widget/app_bar.dart';
import 'package:wellwave_frontend/common/widget/custom_button.dart';
import 'package:wellwave_frontend/common/widget/custom_text_form_field.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_pages.dart';
import 'dart:io';

import 'package:wellwave_frontend/features/health_assessment/presentation/bloc/health_assessment_bloc.dart';
import 'package:wellwave_frontend/features/health_assessment/presentation/bloc/health_assessment_event.dart';
import 'package:wellwave_frontend/features/health_assessment/presentation/bloc/health_assessment_state.dart';
import 'package:wellwave_frontend/features/health_assessment/widget/details_health_card.dart';
import 'package:wellwave_frontend/features/health_assessment/widget/risk_card.dart';
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

    return BlocBuilder<AssessmentBloc, AssessmentState>(
      builder: (context, state) {
        if (state.isCompleted) {
          // print('Assessment is completed!');
          return ResultAssessment();
        }

        return Scaffold(
          appBar: state.isCompleted
              ? null
              : CustomAppBar(
                  context: context,
                  onLeading: true,
                  textColor: Colors.black,
                  backgroundColor: Colors.transparent,
                  onBackPressed: () =>
                      context.read<AssessmentBloc>().add(StepBack()),
                ),
          body: Column(
            children: [
              StepProgressIndicator(
                totalSteps: 6,
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton(
                    width: 250,
                    onPressed: () {
                      context.read<AssessmentBloc>().add(StepContinue());
                      // if (state.currentStep == 2) {
                      //   if ((_formKey.currentState?.validate() ?? false) &&
                      //       state.formData['gender'] != null) {
                      //     context.read<AssessmentBloc>().add(StepContinue());
                      //   } else {
                      //     context.read<AssessmentBloc>().add(ValidateGender());
                      //   }
                      // } else {
                      //   if (_formKey.currentState?.validate() ?? false) {
                      //     {
                      //       context.read<AssessmentBloc>().add(StepContinue());
                      //     }
                      //   }
                      // }
                    },
                    title: state.currentStep == 0
                        ? 'เข้าสู่แบบประเมิน'
                        : state.currentStep == 5
                            ? 'เสร็จสิ้น'
                            : 'ถัดไป',
                  ),
                ),
              ),
            ],
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
          default:
            return Center(child: Text('Unknown Step'));
        }
      }(),
    );
  }
}

class ResultAssessment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 48,
            ),
            Text(
              "ผลการประเมิน",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 32,
            ),
            RiskCard(
              title: 'โรคเบาหวาน',
              riskText: 'คุณมีความเสี่ยงโรคเบาหวานสูง',
              progress: 0.85,
            ),
            const SizedBox(
              height: 24,
            ),
            RiskCard(
              title: 'โรคความดันโลหิตสูง',
              riskText: 'คุณไม่มีความเสี่ยงโรคความดันโลหิตสูง',
              progress: 0.25,
            ),
            const SizedBox(
              height: 24,
            ),
            RiskCard(
              title: 'โรคอ้วน',
              riskText: 'คุณมีความเสี่ยงโรคอ้วนสูง',
              progress: 1,
            ),
            const SizedBox(
              height: 24,
            ),
            RiskCard(
              title: 'โรคไขมันในเลือดสูง',
              riskText: 'คุณมีความเสี่ยงโรคไขมันในเลือดสูงขั้นต้น',
              progress: 0.4,
            ),
            SizedBox(height: 48),
            Positioned(
              bottom: screenHeight * 0.20,
              child: Center(
                child: CustomButton(
                  width: 250,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => _buildResultOverall(context)),
                    );
                  },
                  title: 'เสร็จสิ้น',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultOverall(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        onLeading: false,
        title: 'สรุปผลการประเมิน',
        textColor: Colors.black,
        backgroundColor: Colors.transparent,
      ),
      body: Expanded(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 36),
              DetailsHealthCard(
                title: 'ค่าน้ำตาลในเลือด',
                value: '150 dg/L',
              ),
              SizedBox(height: 24),
              DetailsHealthCard(
                title: 'Cholesterol',
                value: '250 dg/L',
              ),
              SizedBox(height: 24),
              DetailsHealthCard(
                title: 'Triglyceride',
                value: '210 dg/L',
              ),
              SizedBox(height: 48),
              Text(
                "คำแนะนำสำหรับคุณ",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: AppColors.darkblueColor),
              ),
              SizedBox(height: 16),
              Text(
                "• ลดอาหารประเภทแป้ง และอาหารไขมันสูง \n• ออกกำลังกายอย่างสม่ำเสมอ โดยเน้นการคาร์ดิโอ ร่วมกับออกกำลังกายแบบเสริมสร้างกล้ามเนื้อด้วย โดยทำให้ได้อย่างน้อย 3 ครั้งต่อสัปดาห์ ครั้งละ 30-60 นาที ",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppColors.darkblueColor),
              ),
              SizedBox(height: 20),
              Positioned(
                bottom: screenHeight * 0.20,
                child: Center(
                  child: CustomButton(
                    width: 250,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => _buildGoalWeight(context)),
                      );
                    },
                    title: 'กำหนดเป้าหมาย',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGoalWeight(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 108),
            Text(
              "กำหนดเป้าหมายน้ำหนักของคุณ",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: AppColors.blackColor),
            ),
            SizedBox(height: 12),
            Text(
              "บอกให้เราทราบ เพื่อปรับแผนที่เหมาะสมกับคุณมากยิ่งขึ้น",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.blackColor),
            ),
            SizedBox(height: 20),
            CustomButton(
                width: 250,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => _buildFinishGoalWeight(context)),
                  );
                },
                title: 'เสร็จสิ้น'),
          ],
        ),
      ),
    );
  }

  Widget _buildFinishGoalWeight(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "กำหนดเป้าหมายสำเร็จ",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: AppColors.blackColor),
            ),
            SizedBox(height: 16),
            Text(
              "แผนสุขภาพของคุณพร้อมแล้ว!",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: AppColors.blackColor),
            ),
            SizedBox(height: 20),
            CustomButton(
                width: 250,
                onPressed: () {
                  context.goNamed(AppPages.homeName);
                },
                title: 'เข้าสู่หน้าหลัก'),
          ],
        ),
      ),
    );
  }
}
