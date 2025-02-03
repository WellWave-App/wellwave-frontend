import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_pages.dart';
import 'package:wellwave_frontend/features/home/data/models/notification.dart';
import 'package:wellwave_frontend/features/home/presentation/bloc/home_bloc.dart';
import 'package:wellwave_frontend/features/home/presentation/screen/friend_screen.dart';
import 'package:wellwave_frontend/features/home/widget/mockup_data/notification_data.dart';
import 'package:wellwave_frontend/features/home/widget/showpoint.dart';

class TopOfScreen extends StatelessWidget {
  const TopOfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Notifications> notificationlist = getMockNotificationData();
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      bool hasUnread = false;

      if (state is HomeLoadedState) {
        hasUnread = notificationlist.any(
          (notification) =>
              !state.readNotifications.contains(notification.id.toString()),
        );
      }
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CoinDisplay(
                pointText: '150',
                icon: AppImages.expIcon,
              ),
              const SizedBox(width: 16),
              CoinDisplay(
                pointText: '150',
                icon: AppImages.gemIcon,
              ),
            ],
          ),
          Row(
            children: [
              Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      context.goNamed(AppPages.notificationPage);
                      context
                          .read<HomeBloc>()
                          .add(SetHasNewNotificationFalseEvent());
                    },
                    child: SvgPicture.asset(
                      AppImages.notiIcon,
                      height: 32.0,
                    ),
                  ),
                  if (hasUnread)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: AppColors.orangeColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () {
                  context.goNamed(AppPages.friendPage);
                },
                child: SvgPicture.asset(
                  AppImages.avatarDefaultIcon,
                  height: 32.0,
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}
