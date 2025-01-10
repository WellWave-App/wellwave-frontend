import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../../../config/constants/app_strings.dart';
import '../../../data/repositories/notification_repositories.dart';
part 'noti_state.dart';
part 'noti_event.dart';

class NotiBloc extends Bloc<NotiEvent, NotiState> {
  final NotificationSettingRepository _notificationSettingRepository;

  NotiBloc(this._notificationSettingRepository) : super(NotiInitial()) {
    on<CreateBedtimeEvent>((event, emit) async {
      await createBedTime(event.uid, event.isActive, event.bedtime,
          _notificationSettingRepository);
    });
  }

  int uid = AppStrings.uid;

  Future<void> createBedTime(int uid, bool isActive, String bedTime,
      NotificationSettingRepository notiRepository) async {
    try {
      await notiRepository.createBedSetting(
        uid: uid,
        isActive: isActive,
        bedtime: bedTime,
      );
      debugPrint(
          'Bedtime setting created successfully for $uid, $isActive, $bedTime');
    } catch (error) {
      debugPrint('Error submitting log: $error');
    }
  }
}
