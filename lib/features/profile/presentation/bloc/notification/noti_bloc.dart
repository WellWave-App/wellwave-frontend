import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../../../config/constants/app_strings.dart';
import '../../../data/repositories/notification_repositories.dart';
part 'noti_state.dart';
part 'noti_event.dart';

class NotiBloc extends Bloc<NotiEvent, NotiState> {
  final NotificationSettingRepository _notificationSettingRepository;

  NotiBloc(this._notificationSettingRepository) : super(NotiInitial()) {
    on<CreateBedtimeEvent>(_onCreateBedtimeEvent);
    on<UpdateBedtimeEvent>(_onUpdateBedtimeEvent);
    on<FetchBedtimeEvent>(_onFetchBedtimeEvent);
  }

  int uid = AppStrings.uid;

  Future<void> _onCreateBedtimeEvent(
      CreateBedtimeEvent event, Emitter<NotiState> emit) async {
    try {
      await createBedTime(event.uid, event.isActive, event.bedtime,
          _notificationSettingRepository);
      emit(BedtimeState(isActive: event.isActive, bedtime: event.bedtime));
    } catch (error) {
      debugPrint('Error creating bedtime: $error');
    }
  }

  Future<void> _onUpdateBedtimeEvent(
      UpdateBedtimeEvent event, Emitter<NotiState> emit) async {
    try {
      await updateBedTime(
          event.uid, event.isActive, "", _notificationSettingRepository);

      if (state is BedtimeState) {
        final currentState = state as BedtimeState;
        emit(currentState.copyWith(isActive: event.isActive));
      } else {
        emit(BedtimeState(isActive: event.isActive, bedtime: ""));
      }
    } catch (error) {
      debugPrint('Error updating bedtime: $error');
    }
  }

  Future<void> _onFetchBedtimeEvent(
      FetchBedtimeEvent event, Emitter<NotiState> emit) async {
    try {
      if (state is! BedtimeState) {
        final fetchedData =
            await _notificationSettingRepository.fetchBedSetting();
        if (fetchedData != null) {
          debugPrint(
              'Fetched Data: isActive = ${fetchedData.isActive}, bedtime = ${fetchedData.setting.bedtime}');
          emit(BedtimeState(
            isActive: fetchedData.isActive,
            bedtime: fetchedData.setting.bedtime,
          ));
          debugPrint(
              'BedtimeState emitted with isActive: ${fetchedData.isActive}');
        } else {
          debugPrint('Error: No data fetched or data was null');
        }
      }
    } catch (error) {
      debugPrint('Error fetching bedtime: $error');
    }
  }

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

  Future<void> updateBedTime(int uid, bool isActive, String bedTime,
      NotificationSettingRepository notiRepository) async {
    try {
      await notiRepository.updateBedSetting(
        uid: uid,
        isActive: isActive,
      );
      debugPrint('Bedtime setting updated successfully for $uid, $isActive');
    } catch (error) {
      debugPrint('Error submitting log: $error');
    }
  }

  // Future<void> fetchBedTime() async {
  //   try {
  //     // await notiRepository.fetchBedSetting(
  //     //     // uid: uid,
  //     //     // isActive: isActive,
  //     //     // bedtime: bedTime,
  //     //     );
  //     debugPrint('Fetch Bedtime success');
  //   } catch (error) {
  //     debugPrint('Error fetched bedtime: $error');
  //   }
  // }
}
