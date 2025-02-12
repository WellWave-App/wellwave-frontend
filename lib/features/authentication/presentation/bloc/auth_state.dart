part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class RequestResetState extends AuthState {}

class ConfirmCodeState extends AuthState {}

class ResetPasswordState extends AuthState {}

class AuthInitial extends AuthState {}

class Authenticated extends AuthState {}

class Unauthenticated extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}

class AuthLoading extends AuthState {}
