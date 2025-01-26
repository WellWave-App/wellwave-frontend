import 'package:flutter/material.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';

import '../../../../common/widget/app_bar.dart';
import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/app_images.dart';
import '../../../profile/presentation/widget/profile/round_border_text.dart';
import '../widget/switch_button.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int leagueIndex = 0;
    int weekday = DateTime.now().weekday;
    int daysRemain = 7 - weekday;
    String profileImage = '';
    String userName = 'mint';
    int userEXP = 6700;
    int userRank = 16;
    final List<Map<String, dynamic>> rankData = [
      {
        "rank": 4,
        "name": "มายด์",
        "exp": 11370,
        "avatar": "assets/avatar1.png"
      },
      {
        "rank": 5,
        "name": "ยี่หวา",
        "exp": 10270,
        "avatar": "assets/avatar2.png"
      },
      {"rank": 6, "name": "ลิน", "exp": 9820, "avatar": "assets/avatar3.png"},
      {"rank": 7, "name": "มายด์", "exp": 8370, "avatar": "assets/avatar1.png"},
      {
        "rank": 8,
        "name": "ยี่หวา",
        "exp": 8270,
        "avatar": "assets/avatar2.png"
      },
      {"rank": 9, "name": "ลิน", "exp": 7820, "avatar": "assets/avatar3.png"},
      {"rank": 10, "name": "ลิน", "exp": 6820, "avatar": "assets/avatar3.png"},
    ];

    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        appBar: CustomAppBar(
            title: AppStrings.leaderboardText,
            textColor: AppColors.whiteColor,
            context: context,
            onLeading: true),
        body: Stack(children: [
          Column(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SwitchButton(),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RoundedText(
                              text:
                                  '${AppStrings.leagueText}${AppStrings.leagueList[leagueIndex]}',
                              svgPath: AppImages.leagueListIcon[leagueIndex],
                              backgroundColor: Colors.transparent,
                              textColor: AppColors.whiteColor,
                            ),
                            RoundedText(
                              text: weekday != 7
                                  ? 'อีก $daysRemain ${AppStrings.dayText}'
                                  : 'วันสุดท้าย',
                              svgPath: AppImages.clockIcon,
                              backgroundColor: const Color(0xFF2352BC),
                              iconColor: AppColors.whiteColor,
                              textColor: AppColors.whiteColor,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),

              //4-10
              Expanded(
                flex: 1,
                child: Container(
                    padding: const EdgeInsets.only(
                        top: 33, bottom: 95, left: 20, right: 20),
                    color: AppColors.whiteColor,
                    child: ListView.separated(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        itemCount: rankData.length,
                        separatorBuilder: (context, index) => Divider(
                              color: Colors.grey.shade300,
                              thickness: 1,
                            ),
                        itemBuilder: (context, index) {
                          final rankItem = rankData[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Rank Number
                                SizedBox(
                                  width: 42,
                                  child: Text(
                                    '#${rankItem["rank"]}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 24),
                                // Avatar
                                CircleAvatar(
                                  radius: 17,
                                  backgroundImage:
                                      AssetImage(rankItem["avatar"]),
                                ),
                                const SizedBox(width: 36),
                                // Name and EXP
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(rankItem["name"],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith()),
                                      const SizedBox(height: 4),
                                      Text('${rankItem["exp"]} EXP',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith()),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        })),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 95,
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                color: Color(0xFFD0E0FF),
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Rank Number
                    SizedBox(
                      width: 42,
                      child: Text(
                        '#$userRank',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(width: 24),
                    // Avatar
                    CircleAvatar(
                      radius: 17,
                      backgroundImage: AssetImage(profileImage),
                    ),
                    const SizedBox(width: 36),
                    // Name and EXP
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(userName,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith()),
                          const SizedBox(height: 4),
                          Text('$userEXP EXP',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]));
  }
}
