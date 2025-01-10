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

  BedtimeState({required this.isActive, required this.bedtime});

  BedtimeState copyWith({
    bool? isActive,
    String? bedtime,
  }) {
    return BedtimeState(
      isActive: isActive ?? this.isActive,
      bedtime: bedtime ?? this.bedtime,
    );
  }
}

class DrinkPlanState extends NotiState {
  final bool isActive;
  final int glassNumber;
  final String notitime;

  DrinkPlanState(
      {required this.isActive,
      required this.glassNumber,
      required this.notitime});

  DrinkPlanState copyWith({
    bool? isActive,
    String? notitime,
  }) {
    return DrinkPlanState(
      isActive: isActive ?? this.isActive,
      glassNumber: glassNumber,
      notitime: notitime ?? this.notitime,
    );
  }
}
