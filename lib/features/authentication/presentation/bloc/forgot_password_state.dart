part of 'forgot_password_bloc.dart';

@immutable
abstract class ForgotPasswordState {}

class RequestResetState extends ForgotPasswordState {}

class ConfirmCodeState extends ForgotPasswordState {}

class ResetPasswordState extends ForgotPasswordState {}
