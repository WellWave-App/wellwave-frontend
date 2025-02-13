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
import 'package:wellwave_frontend/features/health_assessment/data/models/health_assessment_personal_data_request_model.dart';
import 'package:wellwave_frontend/features/home/presentation/bloc/home_bloc.dart';
import 'package:wellwave_frontend/features/home/presentation/bloc/home_event.dart';
import 'package:wellwave_frontend/features/home/presentation/bloc/home_state.dart';
import 'package:wellwave_frontend/features/home/widget/check_fat.dart';
import 'package:wellwave_frontend/features/home/widget/check_pressure.dart';
import 'package:wellwave_frontend/features/home/widget/check_weight_and_waist.dart';

class ReAssessmentScreen extends StatelessWidget {
  const ReAssessmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    BlocProvider.of<HomeBloc>(context).add(ResetStep());

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoadedState) {
          debugPrint('Current Step: ${state.homeStep}');
          debugPrint('Form Data: ${state.formDataReassessment}');

          return Scaffold(
            appBar: CustomAppBarWithStep(
              context: context,
              onLeading: state.homeStep != 0,
              totalSteps: 3,
              currentStep: state.homeStep,
              textColor: AppColors.blackColor,
              onBackPressed: () => context.read<HomeBloc>().add(PreviousStep()),
            ),
            body: Stack(
              children: [
                Positioned(
                  bottom: 0.0,
                  right: 0.0,
                  child: SvgPicture.asset(
                    AppImages.healthreassessmentBG,
                  ),
                ),
                Column(
                  children: [
                    Expanded(
                      child: Form(
                        key: formKey,
                        child: StepReAssessmentContent(
                            currentStep: state.homeStep),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          CustomButton(
                            width: 250,
                            bgColor: AppColors.primaryColor,
                            textColor: AppColors.whiteColor,
                            title: state.homeStep == 2 ? 'ยืนยัน' : 'ถัดไป',
                            onPressed: () {
                              if (state.homeStep == 2) {
                                if (formKey.currentState!.validate()) {
                                  final model =
                                      HealthAssessmentPersonalDataRequestModel(
                                    weight: double.tryParse(state
                                                .formDataReassessment?['weight']
                                                ?.toString() ??
                                            '') ??
                                        0.0,
                                  );

                                  context
                                      .read<HomeBloc>()
                                      .add(SubmitReAssessmentDataEvent(model));
                                }
                                context.goNamed(AppPages.homePage);
                              }
                              context.read<HomeBloc>().add(NextStep());
                            },
                          ),
                          const SizedBox(height: 4),
                          CustomButton(
                            width: 250,
                            bgColor: AppColors.transparentColor,
                            textColor: AppColors.darkerBlueColor,
                            onPressed: () {
                              context.read<HomeBloc>().add(NextStep());
                              if (state.homeStep == 2) {
                                if (formKey.currentState!.validate()) {
                                  final model =
                                      HealthAssessmentPersonalDataRequestModel(
                                    weight: double.tryParse(state
                                                .formDataReassessment?['weight']
                                                ?.toString() ??
                                            '') ??
                                        0.0,
                                  );

                                  context
                                      .read<HomeBloc>()
                                      .add(SubmitReAssessmentDataEvent(model));
                                }
                                context.goNamed(AppPages.homePage);
                              }
                            },
                            title: AppStrings.nextTimeFieldText,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class StepReAssessmentContent extends StatelessWidget {
  final int currentStep;

  const StepReAssessmentContent({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: () {
        switch (currentStep) {
          case 0:
            return CheckWeightAndWaist();
          case 1:
            return CheckPressure();
          case 2:
            return CheckFat();
          default:
            return const Center(child: Text('Unknown Step'));
        }
      }(),
    );
  }
}
