import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';

import '../../../../common/widget/app_bar.dart';
import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/app_images.dart';
import '../../../profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import '../../../profile/presentation/bloc/profile_bloc/profile_event.dart';
import '../../../profile/presentation/bloc/profile_bloc/profile_state.dart';
import '../../../profile/presentation/widget/profile/round_border_text.dart';
import '../widget/switch_button.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProfileBloc>().add(FetchUserProfile());

    int weekday = DateTime.now().weekday;
    int daysRemain = (14 - weekday) % 14;
    int userRank = 16;

    final List<Map<String, dynamic>> rankData = [
      {"rank": 1, "name": "มงคล", "exp": 12034, "avatar": "assets/avatar3.png"},
      {
        "rank": 2,
        "name": "เปี๊ยก",
        "exp": 12000,
        "avatar": "assets/avatar1.png"
      },
      {"rank": 3, "name": "ฟ้า", "exp": 11944, "avatar": "assets/avatar1.png"},
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
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoaded) {
            final profile = state.userProfile;
            final userLeague = profile.userLeague?.id ?? 0;

            Widget profileImage;

            if (state.userProfile.imageUrl.isNotEmpty) {
              final imageUrl =
                  "http://10.0.2.2:3000${state.userProfile.imageUrl}";
              profileImage = ClipOval(
                child: Image.network(
                  imageUrl,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              );
            } else if (state.selectedImage != null) {
              profileImage = ClipOval(
                child: Image.file(
                  state.selectedImage!,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              );
            } else {
              profileImage = const CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(AppImages.crabImg),
              );
            }

            return Stack(children: [
              Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //league
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RoundedText(
                                  text:
                                      '${AppStrings.leagueText}${AppStrings.leagueList[userLeague - 1]}',
                                  svgPath:
                                      AppImages.leagueListIcon[userLeague - 1],
                                  backgroundColor: Colors.transparent,
                                  textColor: AppColors.whiteColor,
                                ),
                              ],
                            ),

                            //switch
                            const SwitchButton(),
                            //day remain
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                RoundedText(
                                  text: daysRemain != 0
                                      ? '$daysRemain ${AppStrings.dayText}'
                                      : 'วันสุดท้าย',
                                  svgPath: AppImages.clockIcon,
                                  backgroundColor: const Color(0xFF2352BC),
                                  iconColor: AppColors.whiteColor,
                                  textColor: AppColors.whiteColor,
                                ),
                              ],
                            ),
                          ],
                        ),
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
                            itemCount: rankData.length - 3,
                            separatorBuilder: (context, index) => Divider(
                                  color: Colors.grey.shade300,
                                  thickness: 1,
                                ),
                            itemBuilder: (context, index) {
                              final rankItem = rankData[index + 3];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
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
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundImage:
                                          AssetImage(rankItem["avatar"]),
                                    ),
                                    const SizedBox(width: 36),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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

              //1-3
              Positioned(
                bottom: 330,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildPodium(
                        context, rankData[1], AppColors.yellowColor, 93),
                    _buildPodium(context, rankData[0], AppColors.mintColor, 123,
                        isFirst: true),
                    _buildPodium(context, rankData[2], AppColors.pinkColor, 63),
                  ],
                ),
              ),

              //my rank
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 95,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: const BoxDecoration(
                    color: Color(0xFFD0E0FF),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
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
                        profileImage,
                        const SizedBox(width: 36),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(profile.username,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith()),
                              const SizedBox(height: 4),
                              Text('${profile.exp} EXP',
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
            ]);
          } else if (state is ProfileError) {
            return Center(child: Text(state.errorMessage));
          } else if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Center(child: Text(AppStrings.noDataAvaliableText));
          }
        },
      ),
    );
  }

  Widget _buildPodium(BuildContext context, Map<String, dynamic> user,
      Color color, double height,
      {bool isFirst = false}) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage(user['avatar']),
              ),
            ),
            if (isFirst)
              Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SvgPicture.asset(AppImages.firstRankIcon))
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            user['name'],
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text('${user['exp']} exp',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColors.whiteColor, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 16),
        Container(
          width: isFirst ? 177 : 84,
          height: height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
          ),
          child: Text(user['rank'].toString(),
              style: isFirst
                  ? Theme.of(context)
                      .textTheme
                      .titleXL
                      ?.copyWith(color: AppColors.whiteColor)
                  : Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.bold,
                      )),
        ),
      ],
    );
  }
}
