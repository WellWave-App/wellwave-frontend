import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wellwave_frontend/common/widget/app_bar.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_pages.dart';
import 'package:wellwave_frontend/config/routes/app_routes.dart';
import 'package:wellwave_frontend/features/friend/presentation/bloc/friend_bloc.dart';
import 'package:wellwave_frontend/features/friend/presentation/bloc/friend_state.dart';
import 'package:wellwave_frontend/features/friend/presentation/widget/user_info_card.dart';

class FriendScreen extends StatelessWidget {
  const FriendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FriendBloc, FriendState>(builder: (context, state) {
      return Scaffold(
        appBar: CustomAppBar(
          context: context,
          onLeading: false,
          title: 'เพื่อนของฉัน',
          backgroundColor: AppColors.transparentColor,
          actionIcon: SvgPicture.asset(AppImages.alcoholNeverIcon),
          action: () {
            context.goNamed(
              AppPages.findFriendPage,
            );
          },
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // UserInfoCard(),
                // const SizedBox(
                //   height: 16,
                // ),
                // UserInfoCard(),
                SvgPicture.asset(
                  AppImages.fireIcon,
                  width: 128,
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  'ยังไม่มีข้อมูล เพิ่มเพื่อนเลย!',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.darkgrayColor,
                      ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
