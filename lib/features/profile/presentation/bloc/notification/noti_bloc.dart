import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../../../config/constants/app_strings.dart';
import '../../../data/models/drink_plan_notification_response_model.dart';
import '../../../data/repositories/notification_repositories.dart';
part 'noti_state.dart';
part 'noti_event.dart';

class NotiBloc extends Bloc<NotiEvent, NotiState> {
  final NotificationSettingRepository _notificationSettingRepository;

  NotiBloc(this._notificationSettingRepository) : super(NotiInitial()) {
    on<CreateBedtimeEvent>(_onCreateBedtimeEvent);
    on<UpdateBedtimeEvent>(_onUpdateBedtimeEvent);
    on<FetchBedtimeEvent>(_onFetchBedtimeEvent);

    on<CreateDrinkPlanEvent>(_onCreateDrinkPlanEvent);
    on<FetchDrinkPlanEvent>(_onFetchDrinkPlanEvent);
    on<UpdateDrinkPlanEvent>(_onUpdateDrinkPlanEvent);

    on<CreateDrinkRangeEvent>(_onCreateDrinkRangeEvent);
    on<FetchDrinkRangeEvent>(_onFetchDrinkRangeEvent);
    on<UpdateDrinkRangeEvent>(_onUpdateDrinkRangeEvent);
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

  Future<void> _onCreateDrinkPlanEvent(
      CreateDrinkPlanEvent event, Emitter<NotiState> emit) async {
    try {
      final newSetting = DrinkSettingDetail(
        uid: event.uid,
        notificationType: 'WATER_PLAN',
        notitime: event.notitime,
        glassNumber: event.glassNumber,
      );

      await createDrinkPlan(
        event.uid,
        event.glassNumber,
        event.notitime,
        _notificationSettingRepository,
      );

      emit(DrinkPlanState(
        isActive: true,
        settings: [newSetting],
      ));

      debugPrint(
          'DrinkPlan created and state updated: isActive = true, settings count = 1');
    } catch (error) {
      debugPrint('Error creating DrinkPlan: $error');
    }
  }

  Future<void> _onFetchDrinkPlanEvent(
      FetchDrinkPlanEvent event, Emitter<NotiState> emit) async {
    try {
      if (state is! DrinkPlanState) {
        final fetchedData =
            await _notificationSettingRepository.fetchDrinkPlanSetting();

        if (fetchedData != null) {
          debugPrint(
              'bloc Fetched Data: isActive = ${fetchedData.isActive}, settings count = ${fetchedData.setting.length}');

          for (var setting in fetchedData.setting) {
            debugPrint('Setting Detail: ${setting.toJson()}');
          }
          emit(DrinkPlanState(
            isActive: fetchedData.isActive,
            settings: fetchedData.setting,
          ));

          debugPrint(
              'DrinkPlanState emitted with isActive: ${fetchedData.isActive}, settings count = ${fetchedData.setting.length}');
        } else {
          debugPrint('Error: No data fetched or data was null');
        }
      }
    } catch (error) {
      debugPrint('Error fetching drinkPlan: $error');
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

  Future<void> createDrinkPlan(int uid, int glassNumber, String notitime,
      NotificationSettingRepository notiRepository) async {
    try {
      await notiRepository.createDrinkPlanSetting(
        uid: uid,
        glassNumber: glassNumber,
        notitime: notitime,
      );
      debugPrint(
          'DrinkPlan setting created successfully for $uid, $notitime, $glassNumber');
    } catch (error) {
      debugPrint('Error submitting DrinkPlan: $error');
    }
  }

  Future<void> _onUpdateDrinkPlanEvent(
      UpdateDrinkPlanEvent event, Emitter<NotiState> emit) async {
    try {
      await updateDrinkPlan(
          event.uid, event.isActive, _notificationSettingRepository);

      if (state is DrinkPlanState) {
        final currentState = state as DrinkPlanState;

        emit(DrinkPlanState(
          isActive: event.isActive,
          settings: currentState.settings,
        ));
      } else {
        emit(DrinkPlanState(
          isActive: event.isActive,
          settings: [],
        ));
      }

      debugPrint('DrinkPlan updated: isActive = ${event.isActive}');
    } catch (error) {
      debugPrint('Error updating DrinkPlan: $error');
    }
  }

  Future<void> updateDrinkPlan(int uid, bool isActive,
      NotificationSettingRepository notiRepository) async {
    try {
      await notiRepository.updateDrinkPlanSetting(
        uid: uid,
        isActive: isActive,
      );
      debugPrint('DrinkPlan setting updated successfully for $uid, $isActive');
    } catch (error) {
      debugPrint('Error submitting DrinkPlan: $error');
    }
  }

  Future<void> _onCreateDrinkRangeEvent(
      CreateDrinkRangeEvent event, Emitter<NotiState> emit) async {
    try {
      await createDrinkRange(
        event.uid,
        event.startTime,
        event.endTime,
        event.intervalMinute,
        _notificationSettingRepository,
      );
      emit(DrinkRangeState(
        isActive: true,
        startTime: event.startTime,
        endTime: event.endTime,
        intervalMinute: event.intervalMinute,
      ));
    } catch (error) {
      debugPrint('Error creating DrinkRange: $error');
    }
  }

  Future<void> _onFetchDrinkRangeEvent(
      FetchDrinkRangeEvent event, Emitter<NotiState> emit) async {
    try {
      if (state is! DrinkRangeState) {
        final fetchedData =
            await _notificationSettingRepository.fetchDrinkRangeSetting();
        if (fetchedData != null) {
          debugPrint(
              'Fetched Data: isActive = ${fetchedData.isActive}, startTime = ${fetchedData.setting.startTime}, endTime = ${fetchedData.setting.endTime}, intervalMinute = ${fetchedData.setting.intervalMinute}');
          emit(DrinkRangeState(
            isActive: fetchedData.isActive,
            startTime: fetchedData.setting.startTime,
            endTime: fetchedData.setting.endTime,
            intervalMinute: fetchedData.setting.intervalMinute,
          ));
        } else {
          debugPrint('Error: No data fetched or data was null');
        }
      }
    } catch (error) {
      debugPrint('Error fetching DrinkRange: $error');
    }
  }

  Future<void> _onUpdateDrinkRangeEvent(
      UpdateDrinkRangeEvent event, Emitter<NotiState> emit) async {
    try {
      await updateDrinkRange(
          event.uid, event.isActive, "", "", 0, _notificationSettingRepository);

      if (state is DrinkRangeState) {
        final currentState = state as DrinkRangeState;
        emit(currentState.copyWith(isActive: event.isActive));
      } else {
        emit(DrinkRangeState(
            isActive: event.isActive,
            startTime: '',
            endTime: '',
            intervalMinute: 0));
      }
    } catch (error) {
      debugPrint('Error updating drink range: $error');
    }
  }

  Future<void> createDrinkRange(int uid, String startTime, String endTime,
      int intervalMinute, NotificationSettingRepository notiRepository) async {
    try {
      await notiRepository.createDrinkRangeSetting(
        uid: uid,
        startTime: startTime,
        endTime: endTime,
        intervalMinute: intervalMinute,
      );
      debugPrint(
          'DrinkRange setting created successfully for $uid, startTime: $startTime, endTime: $endTime, intervalMinute: $intervalMinute');
    } catch (error) {
      debugPrint('Error creating DrinkRange: $error');
    }
  }

  Future<void> updateDrinkRange(
      int uid,
      bool isActive,
      String startTime,
      String endTime,
      int intervalMinute,
      NotificationSettingRepository notiRepository) async {
    try {
      await notiRepository.updateDrinkRangeSetting(
        uid: uid,
        isActive: isActive,
      );
      debugPrint(
          'DrinkRange setting updated successfully for $uid, isActive: $isActive, startTime: $startTime, endTime: $endTime, intervalMinute: $intervalMinute');
    } catch (error) {
      debugPrint('Error updating DrinkRange: $error');
    }
  }
}
