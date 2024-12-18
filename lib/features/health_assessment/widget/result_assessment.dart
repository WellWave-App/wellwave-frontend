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
import 'package:wellwave_frontend/features/health_assessment/widget/risk_arc.dart';
import 'package:wellwave_frontend/features/health_assessment/widget/risk_card.dart';

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

        if (state.showRecommend) {
          return const RecommendScreen();
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
                        textColor: AppColors.whiteColor,
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

class RecommendScreen extends StatelessWidget {
  const RecommendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HealthAssessmentPageBloc, HealthAssessmentPageState>(
      builder: (context, state) {
        if (state.showHealthConnect) {
          return const HealthConnectScreen();
        }

        String recommendText = '';
        if (state.goalChoose == 'สร้างกล้ามเนื้อ') {
          recommendText = AppStrings.recommendMuscleText;
        } else if (state.goalChoose == 'ลดน้ำหนัก') {
          recommendText = AppStrings.recommendLoseWeightText;
        } else {
          recommendText = AppStrings.recommendHealthyText;
        }

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Stack(
              children: [
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppImages.recommendPlanIcon),
                      const SizedBox(height: 64),
                      Text(
                        "คำแนะนำสำหรับคุณ",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: AppColors.blackColor),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        recommendText,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: AppColors.blackColor),
                      ),
                      const SizedBox(height: 72),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomButton(
                        width: 250,
                        bgColor: AppColors.primaryColor,
                        textColor: AppColors.whiteColor,
                        onPressed: () {
                          context
                              .read<HealthAssessmentPageBloc>()
                              .add(ShowHealthConnectEvent());
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

class HealthConnectScreen extends StatelessWidget {
  const HealthConnectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HealthAssessmentPageBloc, HealthAssessmentPageState>(
      builder: (context, state) {
        if (state.showFinish) {
          return const FinishScreen();
        }
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Stack(
              children: [
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppImages.healthconnectIcon),
                      const SizedBox(height: 64),
                      Text(
                        AppStrings.connectHealthAskText,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: AppColors.blackColor),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        AppStrings.connectHealthDetailsText,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: AppColors.blackColor),
                      ),
                      const SizedBox(height: 72),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 48.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomButton(
                          width: 250,
                          bgColor: AppColors.primaryColor,
                          textColor: AppColors.whiteColor,
                          onPressed: () {
                            context
                                .read<HealthAssessmentPageBloc>()
                                .add(ShowFinishEvent());
                          },
                          title: 'เชื่อมต่อทันที',
                        ),
                        const SizedBox(height: 12),
                        CustomButton(
                          bgColor: Colors.transparent,
                          textColor: AppColors.darkgrayColor,
                          width: 250,
                          onPressed: () {
                            context
                                .read<HealthAssessmentPageBloc>()
                                .add(ShowFinishEvent());
                          },
                          title: 'ไว้ภายหลัง',
                        ),
                      ],
                    ),
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

class FinishScreen extends StatefulWidget {
  const FinishScreen({super.key});

  @override
  _FinishScreenState createState() => _FinishScreenState();
}

class _FinishScreenState extends State<FinishScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 1));

    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 5), () {
      context.goNamed(AppPages.homeName);
    });
    return BlocBuilder<HealthAssessmentPageBloc, HealthAssessmentPageState>(
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Column(
                      children: [
                        SvgPicture.asset(AppImages.recommendIcon),
                        const SizedBox(height: 48),
                        Text(
                          "ยินดีด้วย!",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(color: AppColors.blackColor),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          AppStrings.healthPlanDetailsText,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: AppColors.blackColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topCenter,
                child: RepaintBoundary(
                  child: ConfettiWidget(
                    confettiController: _confettiController,
                    blastDirectionality: BlastDirectionality.explosive,
                    emissionFrequency: 0.3,
                    numberOfParticles: 2,
                    gravity: 0.3,
                    minBlastForce: 1,
                    maxBlastForce: 5,
                    colors: const [
                      AppColors.pinkColor,
                      AppColors.yellowColor,
                      AppColors.mintColor,
                    ],
                    createParticlePath: (size) {
                      return drawTriangle(size);
                    },
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Path drawTriangle(Size size) {
    final path = Path();
    final halfWidth = size.width / 2;
    final height = size.height;

    path.moveTo(halfWidth, 0);

    path.lineTo(size.width, height);
    path.lineTo(0, height);

    path.close();

    return path;
  }
}
