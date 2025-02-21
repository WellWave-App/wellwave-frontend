import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/features/home/presentation/bloc/home_bloc.dart';
import 'package:wellwave_frontend/features/home/presentation/bloc/home_state.dart';
import 'package:wellwave_frontend/features/home/presentation/widget/floating_button_with_shake.dart';
import 'package:wellwave_frontend/features/home/presentation/widget/progress_widget.dart';
import 'package:wellwave_frontend/features/home/presentation/widget/top_of_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HomeLoadedState) {
          final notifications = state.notiData;
          final profileCreateAt = state.profile?.createAt;

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
                      padding: const EdgeInsets.only(
                          top: 40.0, left: 24, right: 24, bottom: 24),
                      child: TopOfScreen(
                        notifications: notifications ?? [],
                      ),
                    ),
                    ProgressWidget(),
                  ],
                ),
              ),
              FutureBuilder<bool>(
                future: isCreateAtDateWithin30Days(profileCreateAt!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.data == true) {
                    return FloatingButtonWithShake();
                  }

                  return const SizedBox.shrink();
                },
              ),
            ],
          );
        } else if (state is HomeError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const Center(child: Text('Initial State'));
        }
      }),
    );
  }
}

Future<bool> isCreateAtDateWithin30Days(DateTime createAt) async {
  final currentDate = DateTime.now();
  final difference = currentDate.difference(createAt).inDays;

  return difference > 30;
}

Future<void> setButtonPressedForCurrentMonth() async {
  final prefs = await SharedPreferences.getInstance();
  final currentMonth = DateTime.now().month;
  await prefs.setInt('lastPressedMonth', currentMonth);
}

Future<void> setLastButtonPressedDate(DateTime dateTime) async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.setInt('last_button_pressed', dateTime.millisecondsSinceEpoch);
}

Future<bool> isButtonPressedRecently() async {
  final prefs = await SharedPreferences.getInstance();
  final lastPressedTimestamp = prefs.getInt('last_button_pressed');

  if (lastPressedTimestamp == null) {
    return true;
  }

  final lastPressedDate =
      DateTime.fromMillisecondsSinceEpoch(lastPressedTimestamp);
  final currentDate = DateTime.now();

  final difference = currentDate.difference(lastPressedDate).inDays;
  return difference > 30;
}
