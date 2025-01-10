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

  // @override
  // List<Object> get props => [uid, isActive, bedtime];
}
