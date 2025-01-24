import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/features/home/presentation/bloc/home_bloc.dart';

class ActionSliderButton extends StatelessWidget {
  final int stepNumber;
  final DateTime date;
  final String progressId;

  ActionSliderButton({
    required this.stepNumber,
    required this.date,
    required this.progressId,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final bloc = context.read<HomeBloc>();
        final isComplete = bloc.completionStatus[progressId]?[date] ?? false;

        return Center(
          child: Container(
            width: 164,
            height: 34,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primaryColor, AppColors.skyblueColor],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(40),
            ),
            child: ActionSlider.standard(
              sliderBehavior: SliderBehavior.stretch,
              height: 34,
              backgroundColor: Colors.transparent,
              toggleColor: AppColors.whiteColor,
              action: (controller) async {
                controller.loading();
                await Future.delayed(const Duration(seconds: 1));
                context.read<HomeBloc>().add(
                      UpdateCompletionStatusEvent(
                        progressId: progressId,
                        date: date,
                        isComplete: true,
                      ),
                    );
                controller.success();
              },
              child: Text(
                'สไลด์เมื่อเสร็จสิ้น',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.whiteColor,
                    ),
              ),
            ),
          ),
        );
      },
    );
  }
}
