import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wellwave_frontend/common/widget/app_bar.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_pages.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/home/data/models/notifications_data_respone_model.dart';
import 'package:wellwave_frontend/features/home/presentation/bloc/home_bloc.dart';
import 'package:wellwave_frontend/features/home/presentation/bloc/home_event.dart';
import 'package:wellwave_frontend/features/home/presentation/bloc/home_state.dart';
import 'package:wellwave_frontend/features/home/widget/notification_item.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          context: context,
          onLeading: true,
          title: 'แจ้งเตือน',
          backgroundColor: AppColors.transparentColor,
          onBackPressed: () {
            context.goNamed(AppPages.homeName);
          },
          actionIcon: Text(
            AppStrings.MarkAsReadAllText,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColors.darkGrayColor,
                ),
          ),
          action: () {
            context.read<HomeBloc>().add(MarkAllAsReadNotiEvent());
          },
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoadedState && state.notiData != null) {
              final latestNotifications = state.notiData!.toList();
              if (latestNotifications.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppImages.avatarNotiImage,
                        width: 128,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        AppStrings.noNotiText,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.darkgrayColor,
                            ),
                      ),
                    ],
                  ),
                );
              }
              return ListView.builder(
                itemCount: latestNotifications.length,
                itemBuilder: (context, index) {
                  final notification = latestNotifications[index];
                  return NotificationItem(notification: notification);
                },
              );
            }
            return Container();
          },
        ));
  }
}
