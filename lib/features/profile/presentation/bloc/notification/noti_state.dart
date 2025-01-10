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
