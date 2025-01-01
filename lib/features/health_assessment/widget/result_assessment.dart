import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wellwave_frontend/common/widget/app_bar.dart';
import 'package:wellwave_frontend/common/widget/custom_button.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_pages.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/config/constants/enums/risk_condition.dart';
import 'package:wellwave_frontend/features/health_assessment/presentation/bloc/lib/features/health_assessment/presentation/health_assessment_page/health_assessment_page_bloc.dart';
import 'package:wellwave_frontend/features/health_assessment/presentation/bloc/lib/features/health_assessment/presentation/health_assessment_page/health_assessment_page_event.dart';
import 'package:wellwave_frontend/features/health_assessment/presentation/bloc/lib/features/health_assessment/presentation/health_assessment_page/health_assessment_page_state.dart';
import 'package:wellwave_frontend/features/health_assessment/widget/component/risk_arc.dart';
import 'package:wellwave_frontend/features/health_assessment/widget/component/risk_card.dart';
import 'package:wellwave_frontend/features/health_assessment/widget/result_goal_step.dart';

class ResultAssessment extends StatelessWidget {
  const ResultAssessment({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HealthAssessmentPageBloc, HealthAssessmentPageState>(
      builder: (context, state) {
        double averageRiskScore = ((state.riskObesityScore / 1) +
                (state.riskDyslipidemiaScore / 4) +
                (state.riskHypertensionScore / 2) +
                (state.riskDiabetesScore / 16)) /
            4;

        if (state.showRecommendStep) {
          return const ResultTask();
        }

        return Scaffold(
          appBar: CustomAppBar(
            context: context,
            onLeading: false,
            title: 'สรุปผลการประเมิน',
            textColor: AppColors.blackColor,
            backgroundColor: AppColors.transparentColor,
          ),
          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Stack(
              children: [
                Column(
                  children: [
                    GaugeWidget(averageRiskScore: averageRiskScore),
                    const SizedBox(height: 48),
                    RiskCard(
                      title: AppStrings.diabetesText,
                      riskScore: state.riskDiabetesScore,
                      getRiskTextMethod: RiskDiseaseCondition.getRiskText,
                    ),
                    const SizedBox(height: 16),
                    RiskCard(
                      title: AppStrings.hypertensionText,
                      riskScore: state.riskHypertensionScore,
                      getRiskTextMethod: RiskHypertensionCondition.getRiskText,
                    ),
                    const SizedBox(height: 16),
                    RiskCard(
                      title: AppStrings.hyperlipidemiaText,
                      riskScore: state.riskDyslipidemiaScore,
                      getRiskTextMethod: RiskDyslipidemiaCondition.getRiskText,
                    ),
                    const SizedBox(height: 16),
                    RiskCard(
                      title: AppStrings.obesityText,
                      riskScore: state.riskObesityScore,
                      getRiskTextMethod: RiskObesityCondition.getRiskText,
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomButton(
                        width: 250,
                        bgColor: AppColors.primaryColor,
                        textColor: AppColors.backgroundColor,
                        onPressed: () {
                          context
                              .read<HealthAssessmentPageBloc>()
                              .add(ShowRecommendEvent());
                        },
                        title: 'ถัดไป',
                      ),
                    ],
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
