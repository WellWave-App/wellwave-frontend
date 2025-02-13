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

class CheckFat extends StatelessWidget {
  const CheckFat({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HealthAssessmentPageBloc, HealthAssessmentPageState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(AppStrings.fatReAssessmentText,
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 72),
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, homestate) {
                  final hdl = (homestate is HomeLoadedState)
                      ? homestate.hdl?.toInt().toString()
                      : AppStrings.hdlText;

                  final ldl = (homestate is HomeLoadedState)
                      ? homestate.ldl?.toInt().toString()
                      : AppStrings.ldlText;

                  return Column(
                    children: [
                      CustomTextFormFieldMD(
                        labelText: AppStrings.ldlText,
                        hintText: ldl.toString(),
                        suffixText: AppStrings.suffixmgPerdLText,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(3),
                        ],
                        onChanged: (value) {
                          context
                              .read<HealthAssessmentPageBloc>()
                              .add(UpdateField('ldl', value));
                        },
                      ),
                      const SizedBox(height: 64),
                      CustomTextFormFieldMD(
                        labelText: AppStrings.hdlText,
                        hintText: hdl.toString(),
                        suffixText: AppStrings.suffixmgPerdLText,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(3),
                        ],
                        onChanged: (value) {
                          context
                              .read<HealthAssessmentPageBloc>()
                              .add(UpdateField('hdl', value));
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
