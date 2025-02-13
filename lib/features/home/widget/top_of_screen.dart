import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_pages.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/home/presentation/bloc/home_bloc.dart';
import 'package:wellwave_frontend/features/home/presentation/bloc/home_event.dart';
import 'package:wellwave_frontend/features/home/presentation/bloc/home_state.dart';
import 'package:wellwave_frontend/features/home/widget/showpoint.dart';

class TopOfScreen extends StatelessWidget {
  const TopOfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        bool hasUnread = false;
        Widget profilePicture;
        if (state is HomeLoadedState) {
          debugPrint("Full IMAGE_URL: '${AppStrings.baseUrl}${state.imageUrl}");
          hasUnread = state.hasNewNotification;

          if (state.imageUrl != '') {
            profilePicture = Image.network(
              '${AppStrings.baseUrl}${state.imageUrl}',
              height: 32.0,
              errorBuilder: (context, error, stackTrace) {
                return SvgPicture.asset(
                  AppImages.avatarDefaultIcon,
                  height: 32.0,
                );
              },
            );
          } else {
            profilePicture = SvgPicture.asset(
              AppImages.avatarDefaultIcon,
              height: 32.0,
            );
          }
        } else {
          profilePicture = SvgPicture.asset(
            AppImages.avatarDefaultIcon,
            height: 32.0,
          );
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CoinDisplay(
                  pointText:
                      (state is HomeLoadedState) ? state.exp.toString() : '0',
                  icon: AppImages.expIcon,
                ),
                const SizedBox(width: 16),
                CoinDisplay(
                  pointText:
                      (state is HomeLoadedState) ? state.gem.toString() : '0',
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
                      const Positioned(
                        right: 0,
                        top: 0,
                        child: SizedBox(
                          width: 16,
                          height: 16,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: AppColors.orangeColor,
                              shape: BoxShape.circle,
                            ),
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
                  child: profilePicture,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
