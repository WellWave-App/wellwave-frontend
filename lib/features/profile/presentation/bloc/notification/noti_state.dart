part of 'noti_bloc.dart';

sealed class NotiState {}

class NotiInitial extends NotiState {}

class NotiLoading extends NotiState {}

class NotiSuccess extends NotiState {}

class NotiError extends NotiState {
  final String message;

  NotiError({required this.message});
}
