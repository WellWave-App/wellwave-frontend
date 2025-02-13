import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/features/home/data/models/notification.dart';
import 'package:wellwave_frontend/features/home/presentation/bloc/home_bloc.dart';
import 'package:wellwave_frontend/features/home/presentation/bloc/home_event.dart';
import 'package:wellwave_frontend/features/home/presentation/bloc/home_state.dart';

class NotificationItem extends StatelessWidget {
  final Notifications notifications;

  NotificationItem({required this.notifications});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        bool isRead = false;

        if (state is HomeLoadedState) {
          isRead =
              state.readNotifications.contains(notifications.id.toString());
        }

        return Container(
          padding: const EdgeInsets.all(16.0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(notifications.image),
            ),
            title: Text(
              notifications.message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      isRead ? AppColors.darkgrayColor : AppColors.blackColor),
            ),
            trailing: Icon(
              Icons.circle,
              color:
                  isRead ? AppColors.transparentColor : AppColors.orangeColor,
              size: 12,
            ),
            onTap: () {
              if (!isRead) {
                context.read<HomeBloc>().add(
                    MarkNotificationAsReadEvent(notifications.id.toString()));
                context.goNamed(notifications.route);
              }
            },
          ),
        );
      },
    );
  }
}
