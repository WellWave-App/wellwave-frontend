part of 'forgot_password_bloc.dart';

@immutable
abstract class ForgotPasswordEvent {}

class RequestResetEvent extends ForgotPasswordEvent {}

class ConfirmCodeEvent extends ForgotPasswordEvent {}

class ResetPasswordEvent extends ForgotPasswordEvent {}
class GoBackEvent extends ForgotPasswordEvent {}

