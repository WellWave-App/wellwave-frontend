import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/profile/presentation/widget/success_dialog.dart';

class CheckInWidget extends StatefulWidget {
  final int currentDay;
  const CheckInWidget({Key? key, required this.currentDay}) : super(key: key);

  @override
  _CheckInWidgetState createState() => _CheckInWidgetState();
}

class _CheckInWidgetState extends State<CheckInWidget> {
  List<bool> checkedInDays = [false, false, false, false, false, false, false];
  final List<int> gemPoints = [20, 20, 20, 20, 20, 20, 100];

  void _checkIn(int dayIndex) {
    if (dayIndex == widget.currentDay && !checkedInDays[dayIndex]) {
      setState(() {
        checkedInDays[dayIndex] = true;
      });
      // Reward the user gems
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const SuccessDialog(reward: 15, iconPath: AppImages.gemIcon);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    onTap: () => _checkIn(index),
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
                          Text('${AppStrings.xdayText} ${index + 1}',
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
                          Text('สำเร็จ',
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
  }
}

