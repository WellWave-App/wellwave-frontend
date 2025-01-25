import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/features/home/data/models/notifications.dart';
import 'package:wellwave_frontend/features/home/presentation/bloc/home_bloc.dart';

class NotificationItem extends StatelessWidget {
  final Notifications notifications;

  const NotificationItem({Key? key, required this.notifications})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 24,
        backgroundImage: NetworkImage(notifications.image),
      ),
      title: Text(
        notifications.message,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: notifications.isRead
                  ? AppColors.darkgrayColor
                  : AppColors.blackColor,
            ),
      ),
      trailing: Icon(
        Icons.circle,
        color:
            notifications.isRead ? Colors.transparent : AppColors.orangeColor,
        size: 16,
      ),
      onTap: () {
        final homeBloc = context.read<HomeBloc>();
        if (!homeBloc.isClosed) {
          debugPrint(
              'HomeBloc is still open. Adding MarkNotificationAsReadEvent.');
          homeBloc.add(MarkNotificationAsReadEvent(notifications.id));
          context.goNamed(notifications.route);
        } else {
          debugPrint('HomeBloc is closed. Cannot add new events.');
        }
      },
    );
  }
}
