import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/profile/presentation/widget/profile/success_dialog.dart';

import '../../bloc/profile_bloc.dart';
import '../../bloc/profile_event.dart';
import '../../bloc/profile_state.dart';

class CheckInWidget extends StatefulWidget {
  const CheckInWidget({Key? key}) : super(key: key);

  @override
  _CheckInWidgetState createState() => _CheckInWidgetState();
}

class _CheckInWidgetState extends State<CheckInWidget> {
  List<bool> checkedInDays = [false, false, false, false, false, false, false];
  List<int> gemPoints = [20, 20, 20, 20, 20, 20, 100];

  late DateTime currentDay;

  @override
  void initState() {
    super.initState();
    currentDay = DateTime.now();
    context.read<ProfileBloc>().add(FetchUserProfile());
  }

  void _checkIn(int dayIndex, ProfileLoaded state) {
    final loginStats = state.userProfile.loginStats;
    final overallStats = state.userProfile.loginStats?.overAllStats;

    if (overallStats == null || loginStats == null) {
      debugPrint("Error: Stats are missing or empty");
      return;
    }

    final lastLoginDate = DateTime.parse(overallStats.lastLoginDate);
    final today = DateTime.now();
    final yesterday = today.subtract(const Duration(days: 1));

    // Calculate days difference
    final difference = today.difference(lastLoginDate).inDays;

    // Check if the last login was yesterday
    final isYesterday = lastLoginDate.year == yesterday.year &&
        lastLoginDate.month == yesterday.month &&
        lastLoginDate.day == yesterday.day;

    // Get current streak from checkInStats
    final checkedDays =
        loginStats.checkInStats.where((stat) => stat.isLogin).length;

    // Case 1: If last login was more than 1 day ago
    if (difference > 1) {
      // Only allow clicking on first day (index 0)
      if (dayIndex == 0 && !checkedInDays[dayIndex]) {
        setState(() {
          // Reset all days to false
          checkedInDays = List.generate(7, (_) => false);
          checkedInDays[0] = true; // Set only first day to true
        });
        _sendCheckInResponse(dayIndex);
      }
      return;
    }

    // Case 2: If last login was yesterday
    if (isYesterday) {
      // Allow clicking only on the next unchecked day
      final nextDayIndex = checkedDays;
      if (dayIndex == nextDayIndex && !checkedInDays[dayIndex]) {
        setState(() {
          checkedInDays[dayIndex] = true;
        });
        _sendCheckInResponse(dayIndex);
      }
      return;
    }

    // Case 3: If already checked in today, don't allow any clicks
    if (lastLoginDate.year == today.year &&
        lastLoginDate.month == today.month &&
        lastLoginDate.day == today.day) {
      return;
    }
  }

  void _sendCheckInResponse(int dayIndex) {
    context.read<ProfileBloc>().add(CreateCheckInResponse(
          date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
        ));

    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return SuccessDialog(
              reward: gemPoints[dayIndex],
              iconPath: AppImages.gemIcon,
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoaded) {
          checkedInDays = state.userProfile.loginStats!.checkInStats
              .map((stat) => stat.isLogin)
              .toList();
          gemPoints = state.userProfile.loginStats!.checkInStats
              .map((stat) => stat.rewardAmount)
              .toList();

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.checkinText,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(7, (index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () => _checkIn(index, state),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: checkedInDays[index]
                                  ? AppColors.primaryColor
                                  : const Color(0xFFF2F2F2),
                            ),
                            child: Column(
                              children: [
                                Text('${AppStrings.xdateText} ${index + 1}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption2
                                        ?.copyWith(
                                            color: checkedInDays[index]
                                                ? AppColors.blackColor
                                                : AppColors.darkGrayColor)),
                                const SizedBox(height: 4),
                                checkedInDays[index]
                                    ? const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      )
                                    : SvgPicture.asset(
                                        AppImages.gemIcon,
                                        height: 24,
                                      ),
                                const SizedBox(height: 4),
                                Text(AppStrings.archeiveText,
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption2
                                        ?.copyWith(
                                            color: checkedInDays[index]
                                                ? AppColors.blackColor
                                                : AppColors.darkGrayColor)),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                      ],
                    );
                  }),
                ),
                const SizedBox(height: 8),
              ],
            ),
          );
        } else if (state is ProfileError) {
          return Center(child: Text(state.errorMessage));
        } else if (state is ProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const Center(child: Text(AppStrings.noDataAvaliableText));
        }
      },
    );
  }
}
