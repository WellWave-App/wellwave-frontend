import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wellwave_frontend/common/widget/app_bar.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/features/friend/presentation/widget/user_info_card.dart';

class FriendScreen extends StatelessWidget {
  const FriendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        onLeading: false,
        backgroundColor: AppColors.transparentColor,
        actionIcon: SvgPicture.asset(AppImages.addfriendsImage),
        action: () {
          print('Action icon pressed');
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            children: [
              UserInfoCard(),
            ],
          ),
        ),
      ),
    );
  }
}
