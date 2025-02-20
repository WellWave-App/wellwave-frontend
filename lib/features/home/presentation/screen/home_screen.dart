import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/features/home/data/models/notifications_data_respone_model.dart';
import 'package:wellwave_frontend/features/home/presentation/bloc/home_bloc.dart';
import 'package:wellwave_frontend/features/home/presentation/bloc/home_event.dart';
import 'package:wellwave_frontend/features/home/presentation/bloc/home_state.dart';
import 'package:wellwave_frontend/features/home/presentation/widget/floating_button_with_shake.dart';
import 'package:wellwave_frontend/features/home/presentation/widget/progress_widget.dart';
import 'package:wellwave_frontend/features/home/presentation/widget/show_result_week_popup.dart';
import 'package:wellwave_frontend/features/home/presentation/widget/top_of_screen.dart';
import 'package:wellwave_frontend/features/profile/data/repositories/profile_repositories.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        if (state is HomeLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is HomeLoadedState) {
          final notifications = state.notiData;

          return Stack(
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
                      child: TopOfScreen(
                        notifications: notifications ?? [],
                      ),
                    ),
                    ProgressWidget(),
                  ],
                ),
              ),
              FloatingButtonWithShake(),
            ],
          );
        } else if (state is HomeError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return Center(child: Text('Initial State'));
        }
      }),
    );
  }
}
