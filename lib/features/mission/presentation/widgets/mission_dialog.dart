import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/features/mission/data/mockup_data.dart';
import 'package:wellwave_frontend/features/mission/presentation/bloc/mission_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellwave_frontend/features/mission/presentation/widgets/success_dialog.dart';

class MissionDialog extends StatelessWidget {
  final String taskName;
  final int taskId;

  const MissionDialog({
    Key? key,
    required this.taskName,
    required this.taskId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: SvgPicture.asset(AppImages.closeBTIcon),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            taskName,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
      content: SizedBox(
        width: 300,
        height: MediaQuery.of(context).size.height * 0.15,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Row(
                  children: [
                    Text(
                      AppStrings.prizesToBeReceivedText,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Row(
                  children: [
                    Image.asset(AppImages.expImage),
                    Text(
                      ' x${mockTasks.firstWhere((task) => task['taskId'] == taskId)['exp']}',
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
            showDialog(
              context: context,
              builder: (_) => SuccessDialog(taskId: taskId),
            );
            context.read<MissionBloc>().add(CompleteTaskEvent(taskId));
            return null;
          },
          elevation: 24,
        ),
      ],
    );
  }
}
