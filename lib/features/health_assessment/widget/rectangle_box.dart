import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellwave_frontend/features/health_assessment/presentation/bloc/health_assessment_bloc.dart';
import 'package:wellwave_frontend/features/health_assessment/presentation/bloc/health_assessment_state.dart';

class RectangleBox extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String icon;
  final bool isMultiSelect;

  const RectangleBox({
    Key? key,
    required this.title,
    required this.icon,
    this.subtitle,
    required this.isMultiSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width / 2 - 32;

    return BlocBuilder<AssessmentBloc, AssessmentState>(
      builder: (context, state) {
        final isSelected = isMultiSelect
            ? state.famhisChoose.contains(title)
            : state.alcoholChoose == title;

        return GestureDetector(
          onTap: () {
            context.read<AssessmentBloc>().add(
                  ToggleSelectionEvent(title, isMultiSelect),
                );
          },
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: containerWidth,
                height: 128,
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primaryColor
                        : Colors.transparent,
                    width: 2.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 4.0,
                      spreadRadius: 0.0,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SvgPicture.asset(
                      icon,
                      height: 32,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.blackColor,
                          ),
                    ),
                    if (subtitle != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          subtitle ?? '',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.darkgrayColor,
                                  ),
                        ),
                      ),
                  ],
                ),
              ),
              if (isSelected)
                Positioned(
                  top: -8,
                  right: -8,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(AppImages.checkmarkIcon),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
