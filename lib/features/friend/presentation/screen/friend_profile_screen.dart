import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wellwave_frontend/common/widget/app_bar.dart';
import 'package:wellwave_frontend/common/widget/custom_button.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_pages.dart';
import 'package:wellwave_frontend/features/friend/presentation/bloc/friend_bloc.dart';
import 'package:wellwave_frontend/features/friend/presentation/bloc/friend_event.dart';
import 'package:wellwave_frontend/features/friend/presentation/bloc/friend_state.dart';
import 'package:wellwave_frontend/features/friend/presentation/widget/user_info.dart';
import 'package:wellwave_frontend/features/profile/data/repositories/profile_repositories.dart';

class ProfileFriends extends StatelessWidget {
  const ProfileFriends({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        onLeading: true,
        backgroundColor: AppColors.transparentColor,
        onBackPressed: () {
          context.goNamed(AppPages.friendPage);
          context.read<FriendBloc>().add(ResetEvent());
        },
        actionIcon: SvgPicture.asset(AppImages.actionIcon),
        action: () {
          context.read<FriendBloc>().add(ToggleUnfriendButtonEvent());
        },
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  UserInformation(
                    userID: 'UID',
                    userName: 'ปลายฟ้า',
                    gemAmount: 20,
                    expAmount: 10,
                  ),
                  // Add any additional widgets here, like charts, etc.
                ],
              ),
            ),
          ),
          BlocBuilder<FriendBloc, FriendState>(
            builder: (context, state) {
              return Stack(
                children: [
                  if (state is FriendShowUnfriendButton && state.isVisible)
                    Positioned(
                      top: 0,
                      right: 24,
                      child: CustomButtonSmall(
                        bgColor: AppColors.whiteColor,
                        outlineColor: AppColors.lightgrayColor,
                        textColor: AppColors.blackColor,
                        title: 'เลิกเป็นเพื่อน',
                        onPressed: () {
                          debugPrint('เลิกเป็นเพื่อน');
                          context.read<FriendBloc>().add(ResetEvent());
                          context.goNamed(AppPages.friendPage);
                        },
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
