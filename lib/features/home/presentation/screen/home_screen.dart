import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/features/home/presentation/bloc/home_bloc.dart';
import 'package:wellwave_frontend/features/home/widget/progress_widget.dart';
import 'package:wellwave_frontend/features/home/widget/progress_widget.dart';
import 'package:wellwave_frontend/features/home/widget/show_assessment_popup.dart';
import 'package:wellwave_frontend/features/home/widget/show_result_week_popup.dart';
import 'package:wellwave_frontend/features/home/widget/top_of_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Stack(
        children: [
          Positioned(
            top: 48.0,
            left: -16.0,
            child: SvgPicture.asset(
              AppImages.cloudImage,
            ),
          ),
          Positioned(
            top: 108.0,
            right: -24.0,
            child: SvgPicture.asset(
              AppImages.cloudImage,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: 40.0, left: 24, right: 24, bottom: 24),
                  child: TopOfScreen(),
                ),
                ProgressWidget(),
              ],
            ),
          ),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: InkWell(
              onTap: () {
                showResultWeekPopup(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 0.1,
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: SvgPicture.asset(
                  AppImages.avatarFloatingAssessmentImage,
                  height: 88.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
