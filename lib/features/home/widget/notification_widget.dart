import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wellwave_frontend/common/widget/app_bar.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_pages.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:wellwave_frontend/features/home/data/models/notifications.dart';
import 'package:wellwave_frontend/features/home/presentation/bloc/home_bloc.dart';
import 'package:wellwave_frontend/features/home/widget/mockup_data/notification_data.dart';
import 'package:wellwave_frontend/features/home/widget/notification_item.dart';
import 'package:flutter_svg/svg.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        onLeading: true,
        title: 'แจ้งเตือน',
        onBackPressed: () {
          context.goNamed(AppPages.homePage);
        },
        backgroundColor: AppColors.transparentColor,
        action: () {
          print('Action icon pressed');
        },
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          final notificationsList = context.read<HomeBloc>().notificationsList;

          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  notificationsList.isNotEmpty
                      ? Column(
                          children: notificationsList
                              .sublist(notificationsList.length - 7)
                              .map((notifications) {
                            return Column(
                              children: [
                                NotificationItem(notifications: notifications),
                                const SizedBox(height: 32),
                              ],
                            );
                          }).toList(),
                        )
                      : Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width - 48,
                          child: Center(
                            child: Text(
                              'ยังไม่มีความคืบหน้า ไปเริ่มทำกันเลย!',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: AppColors.darkgrayColor,
                                  ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
