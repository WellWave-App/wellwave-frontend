import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellwave_frontend/common/widget/custom_text_form_field.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/health_assessment/presentation/bloc/lib/features/health_assessment/presentation/health_assessment_page/health_assessment_page_bloc.dart';
import 'package:wellwave_frontend/features/health_assessment/presentation/bloc/lib/features/health_assessment/presentation/health_assessment_page/health_assessment_page_event.dart';
import 'package:wellwave_frontend/features/health_assessment/presentation/bloc/lib/features/health_assessment/presentation/health_assessment_page/health_assessment_page_state.dart';
import 'package:wellwave_frontend/features/home/presentation/bloc/home_bloc.dart';
import 'package:wellwave_frontend/features/home/presentation/bloc/home_state.dart';

class CheckPressure extends StatelessWidget {
  const CheckPressure({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HealthAssessmentPageBloc, HealthAssessmentPageState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(AppStrings.pressureReAssessmentText,
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 72),
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, homestate) {
                  final diastolicBloodPressure = (homestate is HomeLoadedState)
                      ? homestate.diastolicBloodPressure?.toInt().toString()
                      : AppStrings.diastolicBloodPressureText;

                  final systolicBloodPressure = (homestate is HomeLoadedState)
                      ? homestate.systolicBloodPressure?.toInt().toString()
                      : AppStrings.systolicBloodPressureText;

                  return Column(
                    children: [
                      CustomTextFormFieldMD(
                        labelText: AppStrings.systolicBloodPressureText,
                        hintText: systolicBloodPressure.toString(),
                        suffixText: AppStrings.suffixMillimetersText,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(3),
                        ],
                        onChanged: (value) {
                          context
                              .read<HealthAssessmentPageBloc>()
                              .add(UpdateField('systolicBloodPressure', value));
                        },
                      ),
                      const SizedBox(height: 64),
                      CustomTextFormFieldMD(
                        labelText: AppStrings.diastolicBloodPressureText,
                        hintText: diastolicBloodPressure.toString(),
                        suffixText: AppStrings.suffixMillimetersText,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(3),
                        ],
                        onChanged: (value) {
                          context.read<HealthAssessmentPageBloc>().add(
                              UpdateField('diastolicBloodPressure', value));
                        },
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
