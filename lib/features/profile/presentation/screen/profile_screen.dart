import 'package:flutter/material.dart';
import 'package:wellwave_frontend/common/widget/app_bar.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_pages.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/profile/presentation/widget/check_in_card.dart';
import 'package:wellwave_frontend/features/profile/presentation/widget/progress_card.dart';
import 'package:wellwave_frontend/features/profile/presentation/widget/round_border_text.dart';
import 'package:wellwave_frontend/features/profile/presentation/widget/user_info.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String userID = 'UID450293';
    String userName = 'แจน';
    int leagueIndex = 2;
    int gemAmount = 150;
    int expAmount = 50;
    int currentDay = 4;

    List<String> leagueList = [
      AppStrings.bronzeLeaugeText,
      AppStrings.silverLeaugeText,
      AppStrings.goldLeaugeText,
      AppStrings.diamondLeaugeText,
      AppStrings.emeraldLeaugeText,
    ];

    List<String> leagueListIcon = [
      AppImages.bronzeLeaugeIcon,
      AppImages.silverLeaugeIcon,
      AppImages.goldLeaugeIcon,
      AppImages.diamondLeagueIcon,
      AppImages.emeraldLeaugeIcon,
    ];

    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: CustomAppBar(title: '', context: context, onLeading: true),
        body: SingleChildScrollView(
            child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 24),
                UserInformation(
                  userID: userID,
                  userName: userName,
                  gemAmount: gemAmount,
                  expAmount: expAmount,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: RoundedText(
                        text:
                            '${AppStrings.leagueText}${leagueList[leagueIndex]}',
                        svgPath: leagueListIcon[leagueIndex],
                        isShowNavi: true,
                        appPages: AppPages.articleName,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: RoundedText(
                        text: AppStrings.rewardRedeemText,
                        svgPath: AppImages.giftIcon,
                        isShowNavi: true,
                        appPages: AppPages.articleName,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                CheckInWidget(currentDay: currentDay),
                const SizedBox(height: 24),
                const ProgressCard(
                    daysRemain: 3, exerciseTime: 1, taskAmount: 1, maxExerciseTime: 300, maxTaskAmount: 10,)
                // const WeeklyLogsCard(
                //   title: AppStrings.stepWalkText,
                //   value: '4500',
                //   unit: AppStrings.stepText,
                //   chart: LineChartSample2(),
                // ),
              ],
            ),
          ),
        )));
  }
}
