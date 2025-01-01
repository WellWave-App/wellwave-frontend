import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ruler_picker/flutter_ruler_picker.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/health_assessment/presentation/bloc/lib/features/health_assessment/presentation/health_assessment_page/health_assessment_page_bloc.dart';
import 'package:wellwave_frontend/features/health_assessment/presentation/bloc/lib/features/health_assessment/presentation/health_assessment_page/health_assessment_page_state.dart';
import 'package:wellwave_frontend/features/health_assessment/widget/component/scale_record_widget.dart';

class GoalExerciseScreen extends StatefulWidget {
  @override
  _GoalExerciseScreen createState() => _GoalExerciseScreen();
}

class _GoalExerciseScreen extends State<GoalExerciseScreen> {
  late RulerPickerController _rulerController;
  String? recommendationText;
  int recommendGoalExercise = 150;

  @override
  void initState() {
    super.initState();

    recommendationText = null;
    _rulerController = RulerPickerController(value: recommendGoalExercise);

    if (_rulerController.value == recommendGoalExercise) {
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
                AppStrings.goalExerciseText,
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
                label: 'นาที',
                beginNum: 0,
                endNum: 1000,
                scaleNum: 10,
                initialValue: _rulerController.value,
                controller: _rulerController,
                onValueChanged: (value) {
                  print('Selected Value: $value');
                  setState(() {
                    _rulerController.value = value;
                    if (_rulerController.value == recommendGoalExercise) {
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
