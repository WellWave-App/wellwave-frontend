import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ruler_picker/flutter_ruler_picker.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/health_assessment/presentation/bloc/lib/features/health_assessment/presentation/health_assessment_page/health_assessment_page_bloc.dart';
import 'package:wellwave_frontend/features/health_assessment/presentation/bloc/lib/features/health_assessment/presentation/health_assessment_page/health_assessment_page_state.dart';
import 'package:wellwave_frontend/features/health_assessment/widget/component/scale_record_widget.dart';

class GoalStepScreen extends StatefulWidget {
  @override
  _GoalStepScreen createState() => _GoalStepScreen();
}

class _GoalStepScreen extends State<GoalStepScreen> {
  late RulerPickerController _rulerController;
  String? recommendationText;
  int recommendGoalStep = 0;

  @override
  void initState() {
    super.initState();

    recommendationText = null;
    final yearOfBirth =
        context.read<HealthAssessmentPageBloc>().state.formData['birthYear'];

    int age = 0;

    if (yearOfBirth != null) {
      int? birthYear = int.tryParse(yearOfBirth);

      if (birthYear != null) {
        int currentYear = DateTime.now().year;
        age = currentYear - birthYear;
      }
    }

    if (age <= 30) {
      recommendGoalStep = 80000;
    } else if (age > 30 && age <= 60) {
      recommendGoalStep = 60000;
    } else {
      recommendGoalStep = 40000;
    }

    _rulerController = RulerPickerController(value: recommendGoalStep);

    if (_rulerController.value == recommendGoalStep) {
      recommendationText = AppStrings.recommendText;
    } else {
      recommendationText = null;
    }
  }

  @override
  void dispose() {
    _rulerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HealthAssessmentPageBloc, HealthAssessmentPageState>(
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              Text(
                AppStrings.goalStepText,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: AppColors.blackColor),
              ),
              const SizedBox(height: 128),
              recommendationText != ''
                  ? Container(
                      padding: EdgeInsets.only(
                          top: 4.0, bottom: 4.0, left: 24.0, right: 24.0),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        recommendationText!,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.whiteColor,
                            ),
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.only(
                          top: 4.0, bottom: 4.0, left: 24.0, right: 24.0),
                      decoration: BoxDecoration(
                        color: AppColors.transparentColor,
                      ),
                      child: Text(
                        recommendationText!,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.transparentColor,
                            ),
                      ),
                    ),
              const SizedBox(height: 8),
              ScaleRecordWidget(
                label: 'ก้าว',
                beginNum: 1000,
                endNum: 200000,
                scaleNum: 1000,
                initialValue: _rulerController.value,
                controller: _rulerController,
                onValueChanged: (value) {
                  print('Selected Value: $value');
                  setState(() {
                    _rulerController.value = value;
                    if (_rulerController.value == recommendGoalStep) {
                      recommendationText = AppStrings.recommendText;
                    } else {
                      recommendationText = '';
                    }
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
