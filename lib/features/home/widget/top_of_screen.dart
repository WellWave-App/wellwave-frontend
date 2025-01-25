import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_pages.dart';
import 'package:wellwave_frontend/features/home/presentation/bloc/home_bloc.dart';
import 'package:wellwave_frontend/features/home/presentation/screen/friend_screen.dart';
import 'package:wellwave_frontend/features/home/widget/showpoint.dart';

class TopOfScreen extends StatelessWidget {
  const TopOfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CoinDisplay(
                pointText: '150',
                icon: AppImages.expIcon,
              ),
              const SizedBox(
                width: 16,
              ),
              CoinDisplay(
                pointText: '150',
                icon: AppImages.gemIcon,
              ),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  final homeBloc = context.read<HomeBloc>();
                  if (!homeBloc.isClosed) {
                    context.goNamed(
                      AppPages.notificationPage,
                      extra: homeBloc,
                    );
                  }
                },
                child: SvgPicture.asset(
                  AppImages.notiIcon,
                  height: 32.0,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
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
