import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ruler_picker/flutter_ruler_picker.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/features/health_assessment/presentation/bloc/lib/features/health_assessment/presentation/health_assessment_page/health_assessment_page_bloc.dart';
import 'package:wellwave_frontend/features/health_assessment/presentation/bloc/lib/features/health_assessment/presentation/health_assessment_page/health_assessment_page_state.dart';
import 'package:wellwave_frontend/features/health_assessment/widget/component/scale_record_widget.dart';

class GoalStepScreen extends StatefulWidget {
  @override
  _GoalStepScreen createState() => _GoalStepScreen();
}

class _GoalStepScreen extends State<GoalStepScreen> {
  late RulerPickerController _rulerController;

  @override
  void initState() {
    super.initState();
    _rulerController = RulerPickerController(value: 50); // ค่าเริ่มต้น 50
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
                "กำหนดเป้าหมายจำนวนก้าวเดินต่อสัปดาห์",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: AppColors.blackColor),
              ),
              const SizedBox(height: 72),
              ScaleRecordWidget(
                label: 'kg',
                initialValue: _rulerController.value,
                controller: _rulerController,
                onValueChanged: (value) {
                  print('Selected Value: $value');
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
