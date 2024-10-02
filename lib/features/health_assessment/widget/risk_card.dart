import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/enums/risk_condition.dart';
import 'package:wellwave_frontend/features/health_assessment/presentation/bloc/lib/features/health_assessment/presentation/health_assessment_page/health_assessment_page_bloc.dart';
import 'package:wellwave_frontend/features/health_assessment/presentation/bloc/lib/features/health_assessment/presentation/health_assessment_page/health_assessment_page_state.dart';

class RiskCard extends StatelessWidget {
  final String title;
  final int riskScore;
  final Function(int) getRiskTextMethod;

  const RiskCard({
    super.key,
    required this.title,
    required this.riskScore,
    required this.getRiskTextMethod,
  });

  @override
  Widget build(BuildContext context) {
    var riskInfo = getRiskTextMethod(riskScore);
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            spreadRadius: 0,
            blurRadius: 5,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: Theme.of(context).textTheme.bodyMedium),
            Text(
              riskInfo['text'],
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: riskInfo['color']),
            ),
          ],
        ),
      ),
    );
  }
}

class ResultAssessment extends StatelessWidget {
  const ResultAssessment({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HealthAssessmentPageBloc, HealthAssessmentPageState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text('สรุปผลการประเมิน')),
          body: Column(
            children: [
              RiskCard(
                title: "เบาหวาน",
                riskScore: state.riskDiabetesScore,
                getRiskTextMethod: RiskDiseaseCondition.getRiskText,
              ),
              RiskCard(
                title: "ความดันโลหิต",
                riskScore: state.riskHypertensionScore,
                getRiskTextMethod: RiskHypertensionCondition.getRiskText,
              ),
              RiskCard(
                title: "ไขมันในเลือด",
                riskScore: state.riskDyslipidemiaScore,
                getRiskTextMethod: RiskDyslipidemiaCondition.getRiskText,
              ),
              RiskCard(
                title: "โรคอ้วน",
                riskScore: state.riskObesityScore,
                getRiskTextMethod: RiskObesityCondition.getRiskText,
              ),
            ],
          ),
        );
      },
    );
  }
}
