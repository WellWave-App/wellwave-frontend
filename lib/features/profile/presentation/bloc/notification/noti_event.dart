part of 'noti_bloc.dart';

sealed class NotiEvent {}

class CreateBedtimeEvent extends NotiEvent {
  final int uid;
  final bool isActive;
  final String bedtime;

  CreateBedtimeEvent({
    required this.uid,
    required this.isActive,
    required this.bedtime,
  });
}

class FetchBedtimeEvent extends NotiEvent {}

class FetchDrinkPlanEvent extends NotiEvent {}

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
