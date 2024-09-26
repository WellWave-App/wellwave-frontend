import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/mission/presentation/bloc/mission_bloc.dart';

class TaskListView extends StatelessWidget {
  final String? imagePath;

  const TaskListView({super.key, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              spreadRadius: 0.5,
              blurRadius: 4,
            ),
          ],
        ),
        padding: const EdgeInsets.all(2.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imagePath != null
                        ? AssetImage(imagePath!)
                        : const AssetImage(AppImages.emptyComponentImage),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                'ชื่อภารกิจ',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(AppImages.expImage),
                        const Text(' x10'),
                      ],
                    ),
                  ),
                  BlocBuilder<MissionBloc, MissionState>(
                    builder: (context, state) {
                      bool isButtonDisabled = state is TaskCompletedState;

                      return ElevatedButton(
                        onPressed: isButtonDisabled
                            ? null
                            : () {
                                _showMissionDialog(context);
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isButtonDisabled
                              ? Colors.grey
                              : AppColors.primaryColor,
                          foregroundColor: AppColors.whiteColor,
                          minimumSize: const Size(64, 28),
                          side: const BorderSide(
                            color: AppColors.whiteColor,
                            width: 2.0,
                          ),
                          elevation: 2,
                          shadowColor: AppColors.darkGrayColor,
                        ),
                        child: Text(
                          AppStrings.startText,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(color: AppColors.whiteColor),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMissionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'missionName',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          content: SizedBox(
            width: 300,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0, bottom: 48),
                    child: Row(
                      children: [
                        Image.asset(AppImages.expImage),
                        Text(
                          ' x15',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            SlideAction(
              outerColor: AppColors.secondaryDarkColor,
              text: AppStrings.slideForSuccessText,
              textStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppColors.whiteColor,
                  ),
              sliderButtonIcon: Row(
                children: [SvgPicture.asset(AppImages.arrowForwardIcon)],
              ),
              onSubmit: () {
                Navigator.of(context).pop();

                _showSuccessDialog(context);
                return null;
              },
              elevation: 24,
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        bool isDialogClosed = false;

        Future.delayed(const Duration(seconds: 3), () {
          if (!isDialogClosed) {
            Navigator.of(context).pop();
            context.read<MissionBloc>().add(CompleteTaskEvent());
            isDialogClosed = true;
          }
        });

        return Dialog(
          backgroundColor: Colors.transparent,
          child: Center(
            child: Container(
              width: 300,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.all(30.0),
                            child: const Padding(
                              padding: EdgeInsets.only(top: 36.0),
                              child: Column(
                                children: [
                                  Text(
                                    AppStrings.youReceivedText,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.monetization_on,
                                        color: Colors.amber,
                                        size: 30,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'x15',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 36.0),
                            child: GestureDetector(
                              onTap: () {
                                if (!isDialogClosed) {
                                  Navigator.of(context).pop();
                                  context
                                      .read<MissionBloc>()
                                      .add(CompleteTaskEvent());
                                  isDialogClosed = true;
                                }
                              },
                              child: const Text(
                                AppStrings.closeWindowText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Image.asset(AppImages.barSuccessImage),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
