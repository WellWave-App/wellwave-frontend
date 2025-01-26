part of 'noti_bloc.dart';

sealed class NotiEvent {}

class CreateBedtimeEvent extends NotiEvent {
  final int uid;
  final bool isActive;
  final String bedtime;

  final Map<String, bool> weekdays;

  CreateBedtimeEvent({
    required this.uid,
    required this.isActive,
    required this.bedtime,
    required this.weekdays,
  });
}

class FetchBedtimeEvent extends NotiEvent {}

class FetchDrinkPlanEvent extends NotiEvent {}

class FetchDrinkRangeEvent extends NotiEvent {}

class UpdateBedtimeEvent extends NotiEvent {
  final int uid;
  final bool isActive;

  UpdateBedtimeEvent({
    required this.uid,
    required this.isActive,
  });
}

class CreateDrinkPlanEvent extends NotiEvent {
  final int uid;
  final int glassNumber;
  final String notitime;

  CreateDrinkPlanEvent({
    required this.uid,
    required this.glassNumber,
    required this.notitime,
  });
}

class UpdateDrinkPlanEvent extends NotiEvent {
  final int uid;
  final bool isActive;

  UpdateDrinkPlanEvent({
    required this.uid,
    required this.isActive,
  });
}

class CreateDrinkRangeEvent extends NotiEvent {
  final int uid;
  final String startTime;
  final String endTime;
  final int intervalMinute;

  CreateDrinkRangeEvent({
    required this.uid,
    required this.startTime,
    required this.endTime,
    required this.intervalMinute,
  });
}

class UpdateDrinkRangeEvent extends NotiEvent {
  final int uid;
  final bool isActive;

  UpdateDrinkRangeEvent({
    required this.uid,
    required this.isActive,
  });
}
