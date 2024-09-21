import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/profile/presentation/widget/reward_card.dart';
import 'package:wellwave_frontend/features/profile/presentation/widget/round_border_text.dart';

class UserInformation extends StatelessWidget {
  final String userID;
  final String userName;
  final int
      leagueIndex; // Use leagueIndex instead of passing league name directly
  final int gemAmount;
  final int expAmount;

  const UserInformation({
    Key? key,
    required this.userID,
    required this.userName,
    required this.leagueIndex, // New leagueIndex parameter
    required this.gemAmount,
    required this.expAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> leagueList = [
      AppStrings.bronzeLeaugeText,
      AppStrings.silverLeaugeText,
      AppStrings.goldLeaugeText,
      AppStrings.diamondLeaugeText,
      AppStrings.emeraldLeaugeText,
    ];

    return Column(
      children: [
        const SizedBox(height: 16),
        const CircleAvatar(
          radius: 64,
          backgroundColor: AppColors.mintColor,
        ),
        const SizedBox(height: 24),
        Text(
          userName,
          style: Theme.of(context).textTheme.titleLargeBold?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${AppStrings.idText}: $userID',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(),
            ),
            IconButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: userID));
                // Optionally, you can show a confirmation message (like a Snackbar)
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('User ID copied to clipboard'),
                  duration: Duration(seconds: 2),
                ));
              },
              icon: SvgPicture.asset(AppImages.copyIcon),
            )
          ],
        ),
        const SizedBox(height: 24),
        RoundedText(
          text: '${AppStrings.leagueText} ${leagueList[leagueIndex]}',
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RewardCard(
              iconPath: AppImages.articleIcon,
              amount: '$gemAmount',
              unitLabel: AppStrings.gemText,
            ),
            const SizedBox(width: 16),
            RewardCard(
              iconPath: AppImages.articleIcon,
              amount: '$expAmount',
              unitLabel: AppStrings.expText,
            ),
          ],
        ),
        const SizedBox(height: 24),
        const Divider(color: Colors.black),
        const SizedBox(height: 24),
      ],
    );
  }
}
