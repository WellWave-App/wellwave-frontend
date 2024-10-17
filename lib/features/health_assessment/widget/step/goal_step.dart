import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/features/health_assessment/presentation/bloc/lib/features/health_assessment/presentation/health_assessment_page/health_assessment_page_bloc.dart';
import 'package:wellwave_frontend/features/health_assessment/presentation/bloc/lib/features/health_assessment/presentation/health_assessment_page/health_assessment_page_state.dart';
import 'package:wellwave_frontend/features/health_assessment/widget/goal_box.dart';

class GoalStep extends StatelessWidget {
  const GoalStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HealthAssessmentPageBloc, HealthAssessmentPageState>(
      builder: (context, state) {
        double weight = state.formData['weight'] != null
            ? double.tryParse(state.formData['weight']!) ?? 0.0
            : 0.0;
        double height = state.formData['height'] != null
            ? (double.tryParse(state.formData['height']!) ?? 0.0) / 100
            : 0.0;

        double bmi = (height > 0) ? (weight / (height * height)) : 0.0;

        if (bmi < 18.5 && state.goalChoose == 'ลดน้ำหนัก') {
          context.read<HealthAssessmentPageBloc>().add(
                ToggleSelectionEvent('', false, 'goal'),
              );
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "สุดท้ายแล้ว! บอกเป้าหมายของคุณให้เรารู้หน่อยได้ไหม?",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 48,
              ),
              const GoalBox(
                icon: AppImages.goalMuscleIcon,
                title: "สร้างกล้ามเนื้อ",
                isMultiSelect: false,
              ),
              const SizedBox(
                height: 24,
              ),
              const GoalBox(
                icon: AppImages.goalHealthyIcon,
                title: "สุขภาพดี",
                isMultiSelect: false,
              ),
              if (bmi > 18.5) ...[
                const SizedBox(
                  height: 24,
                ),
                const GoalBox(
                  icon: AppImages.goalLoseweightIcon,
                  title: "ลดน้ำหนัก",
                  isMultiSelect: false,
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
