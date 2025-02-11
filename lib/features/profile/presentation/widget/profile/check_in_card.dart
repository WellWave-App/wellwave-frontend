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

class CheckInWidget extends StatelessWidget {
  final ProfileLoaded profileState;

  const CheckInWidget({Key? key, required this.profileState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginStats = profileState.userProfile.loginStats;
    final overallStats = profileState.userProfile.loginStats?.overAllStats;

    if (overallStats == null || loginStats == null) {
      return const Center(child: Text("Error: Stats are missing or empty"));
    }

    List<bool> checkedInDays =
        loginStats.checkInStats.map((stat) => stat.isLogin).toList();
    List<int> gemPoints =
        loginStats.checkInStats.map((stat) => stat.rewardAmount).toList();

    void checkIn(int dayIndex) {
      final lastLoginDate = DateTime.parse(overallStats.lastLoginDate);
      final today = DateTime.now();
      final yesterday = today.subtract(const Duration(days: 1));
      final difference = today.difference(lastLoginDate).inDays;

      final isYesterday = lastLoginDate.year == yesterday.year &&
          lastLoginDate.month == yesterday.month &&
          lastLoginDate.day == yesterday.day;

      final checkedDays =
          loginStats.checkInStats.where((stat) => stat.isLogin).length;

      if (difference > 1 && dayIndex != 0) return;
      if (isYesterday && dayIndex != checkedDays) return;
      if (lastLoginDate.year == today.year &&
          lastLoginDate.month == today.month &&
          lastLoginDate.day == today.day) {
        return;
      }

      context.read<ProfileBloc>().add(CreateCheckInResponse(
            date: DateFormat('yyyy-MM-dd').format(today),
          ));

      Future.delayed(const Duration(milliseconds: 100), () {
        if (context.mounted) {
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
                    onTap: () => checkIn(index),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: (DateTime.now().weekday - 1 == index &&
                                !checkedInDays[index])
                            ? AppColors.backgroundColor
                            : const Color(0xFFF2F2F2),
                        border: Border.all(
                            color: (DateTime.now().weekday - 1 == index &&
                                    !checkedInDays[index])
                                ? AppColors.secondaryDarkColor
                                : Colors.transparent,
                            width: 1.5,
                            strokeAlign: BorderSide.strokeAlignInside),
                      ),
                      child: Column(
                        children: [
                          Text('${AppStrings.xdateText} ${index + 1}',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption2
                                  ?.copyWith(
                                      color: (DateTime.now().weekday - 1 ==
                                                  index &&
                                              !checkedInDays[index])
                                          ? AppColors.blackColor
                                          : AppColors.darkGrayColor)),
                          const SizedBox(height: 4),
                          (DateTime.now().weekday - 1 == index &&
                                  !checkedInDays[index])
                              ? SvgPicture.asset(AppImages.gemIcon, height: 24)
                              : checkedInDays[index]
                                  ? SvgPicture.asset(AppImages.gemCheckSvg,
                                      height: 24)
                                  : SvgPicture.asset(AppImages.gemNotCheckSvg,
                                      height: 24),
                          const SizedBox(height: 4),
                          Text(
                              checkedInDays[index]
                                  ? AppStrings.archeiveText
                                  : '${gemPoints[index]}',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption2
                                  ?.copyWith(
                                      color: (DateTime.now().weekday - 1 ==
                                                  index &&
                                              !checkedInDays[index])
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
  }
}
