import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ruler_picker/flutter_ruler_picker.dart';
import 'package:wellwave_frontend/common/widget/custom_text_form_field.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/health_assessment/presentation/bloc/lib/features/health_assessment/presentation/health_assessment_page/health_assessment_page_bloc.dart';
import 'package:wellwave_frontend/features/health_assessment/presentation/bloc/lib/features/health_assessment/presentation/health_assessment_page/health_assessment_page_event.dart';
import 'package:wellwave_frontend/features/health_assessment/presentation/bloc/lib/features/health_assessment/presentation/health_assessment_page/health_assessment_page_state.dart';
import 'package:wellwave_frontend/features/health_assessment/widget/component/scale_record_widget.dart';

class GoalExerciseScreen extends StatefulWidget {
  @override
  _GoalExerciseScreen createState() => _GoalExerciseScreen();
}

class _GoalExerciseScreen extends State<GoalExerciseScreen> {
  String? recommendationText;
  int recommendGoalEx = 150;

  @override
  void initState() {
    super.initState();

    final currentGoalEx = context
        .read<HealthAssessmentPageBloc>()
        .state
        .formData['userGoalExTimeWeek'];

    if (currentGoalEx == null || currentGoalEx.isEmpty) {
      context
          .read<HealthAssessmentPageBloc>()
          .add(UpdateField('userGoalExTimeWeek', recommendGoalEx.toString()));
    }

    recommendationText = AppStrings.recommendText;
    debugPrint("userGoalEx: $currentGoalEx");
    debugPrint("recommendGoalEx: $recommendGoalEx");
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HealthAssessmentPageBloc, HealthAssessmentPageState>(
      builder: (context, state) {
        final userGoalEx =
            state.formData['userGoalExTimeWeek'] ?? recommendGoalEx.toString();

        return Scaffold(
          backgroundColor: AppColors.transparentColor,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.goalExerciseText,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: AppColors.blackColor),
              ),
              const SizedBox(height: 64),
              if (userGoalEx == recommendGoalEx.toString())
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 4.0, horizontal: 24.0),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    recommendationText!,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AppColors.whiteColor,
                        ),
                  ),
                )
              else
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 4.0, horizontal: 24.0),
                  decoration: BoxDecoration(
                    color: AppColors.transparentColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    recommendationText!,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AppColors.transparentColor,
                        ),
                  ),
                ),
              const SizedBox(height: 16),
              CustomTextFormFieldLarge(
                hintText: AppStrings.exCountText,
                keyboardType: TextInputType.number,
                suffixText: AppStrings.suffixMinuteText,
                initialValue: userGoalEx,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(6),
                ],
                onChanged: (value) => context
                    .read<HealthAssessmentPageBloc>()
                    .add(UpdateField('userGoalExTimeWeek', value)),
              ),
            ],
          ),
        );
      },
    );
  }
}
