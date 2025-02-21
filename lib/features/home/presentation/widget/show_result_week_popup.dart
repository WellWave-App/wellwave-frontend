import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wellwave_frontend/features/home/presentation/bloc/home_bloc.dart';
import 'package:wellwave_frontend/features/home/presentation/bloc/home_state.dart';
import 'package:wellwave_frontend/features/home/presentation/widget/circular_chart_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> checkAndShowPopup(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  final lastShownDate = prefs.getString('lastShownDate');

  final currentDate = DateTime.now();
  final isSunday = currentDate.weekday == DateTime.sunday;

  if (isSunday &&
      (lastShownDate == null ||
          lastShownDate != currentDate.weekday.toString())) {
    showResultWeekPopup(context);
    await prefs.setString('lastShownDate', currentDate.weekday.toString());
  }
}

Future<void> showResultWeekPopup(BuildContext context) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.8),
    builder: (BuildContext context) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border(
                        bottom: BorderSide(
                          color: AppColors.popUpSkyBlueColor,
                          width: 8.0,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 16.0),
                          Text(
                            AppStrings.resultThisWeekText,
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(color: AppColors.blackColor),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            AppStrings.greatjobText,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: AppColors.blackColor,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24.0),
                          BlocBuilder<HomeBloc, HomeState>(
                            builder: (context, state) {
                              if (state is HomeLoadedState) {
                                final healthData =
                                    state.healthStepAndExData!.data;
                                final lastWeekDates = getLastWeekDates();

                                final dailyHabitGoal =
                                    (state.profile?.exercisePerWeek ?? 1)
                                            .toDouble() /
                                        7;
                                final dailyStepGoal =
                                    (state.profile?.stepPerWeek ?? 1)
                                            .toDouble() /
                                        7;

                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        for (int i = 0; i < 4; i++)
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12.0),
                                            child: CircularChartWidget(
                                              date: lastWeekDates[i],
                                              healthData: healthData,
                                              dailyHabitGoal: dailyHabitGoal,
                                              dailyStepGoal: dailyStepGoal,
                                            ),
                                          ),
                                      ],
                                    ),
                                    const SizedBox(height: 20.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        for (int i = 4; i < 7; i++)
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12.0),
                                            child: CircularChartWidget(
                                              date: lastWeekDates[i],
                                              healthData: healthData,
                                              dailyHabitGoal: dailyHabitGoal,
                                              dailyStepGoal: dailyStepGoal,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                );
                              }
                              return CircularProgressIndicator();
                            },
                          ),
                          const SizedBox(height: 24.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: AppColors.darkPinkColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 4.0),
                              Text(
                                AppStrings.exerciseText,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                      color: AppColors.darkPinkColor,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(width: 16.0),
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: AppColors.secondaryDarkColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 4.0),
                              Text(
                                AppStrings.stepText,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                      color: AppColors.secondaryDarkColor,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "ปิดหน้าต่างนี้",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.grayColor,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.grayColor,
                          ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: -36,
                right: -16,
                child: SvgPicture.asset(
                  AppImages.hatIcon,
                  height: 84.0,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

List<DateTime> getLastWeekDates() {
  DateTime now = DateTime.now();
  DateTime lastWeekStart = now.subtract(Duration(days: now.weekday + 7));
  return List.generate(7, (index) => lastWeekStart.add(Duration(days: index)));
}
