import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/features/home/presentation/bloc/home_bloc.dart';
import 'package:wellwave_frontend/features/home/widget/greeting_widget.dart';
import 'package:wellwave_frontend/features/home/widget/progress_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
        child: Stack(
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
            const Column(
              children: [
                GreetingWidget(),
                ProgressWidget(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
