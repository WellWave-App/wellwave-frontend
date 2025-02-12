part of 'noti_bloc.dart';

sealed class NotiState {}

class NotiInitial extends NotiState {}

class NotiLoading extends NotiState {}

class NotiSuccess extends NotiState {}

class NotiError extends NotiState {
  final String message;

  NotiError({required this.message});
}

class BedtimeState extends NotiState {
  final bool isActive;
  final String bedtime;
  final Map<String, bool> weekdays;

  BedtimeState({
    required this.isActive,
    required this.bedtime,
    required this.weekdays,
  });

  BedtimeState copyWith({
    bool? isActive,
    String? bedtime,
    Map<String, bool>? weekdays,
  }) {
    return BedtimeState(
      isActive: isActive ?? this.isActive,
      bedtime: bedtime ?? this.bedtime,
      weekdays: weekdays ?? this.weekdays,
    );
  }
}

class DrinkPlanState extends NotiState {
  final bool isActive;
  final List<DrinkSettingDetail> settings;

  DrinkPlanState({
    required this.isActive,
    required this.settings,
  });

  DrinkPlanState copyWith({
    bool? isActive,
    List<DrinkSettingDetail>? settings,
  }) {
    return DrinkPlanState(
      isActive: isActive ?? this.isActive,
      settings: settings ?? this.settings,
    );
  }
}

class DrinkRangeState extends NotiState {
  final bool isActive;
  final String startTime;
  final String endTime;
  final int intervalMinute;

  DrinkRangeState(
      {required this.isActive,
      required this.startTime,
      required this.endTime,
      required this.intervalMinute});

  DrinkRangeState copyWith({
    bool? isActive,
    String? notitime,
  }) {
    return DrinkRangeState(
      isActive: isActive ?? this.isActive,
      startTime: startTime,
      endTime: endTime,
      intervalMinute: intervalMinute,
    );
  }
}

class MissionState extends NotiState {
  final bool isNotificationEnabled;
  final String title;
  final Map<String, bool> weekdaysNoti;
  final int total;

  MissionState({
    required this.isNotificationEnabled,
    required this.title,
    required this.weekdaysNoti,
    required this.total,
  });

  MissionState copyWith({
    bool? isNotificationEnabled,
    String? title,
    Map<String, bool>? weekdaysNoti,
    int? total,
  }) {
    return MissionState(
      isNotificationEnabled:
          isNotificationEnabled ?? this.isNotificationEnabled,
      title: title ?? this.title,
      weekdaysNoti: weekdaysNoti ?? this.weekdaysNoti,
      total: total ?? this.total,
    );
  }
}
