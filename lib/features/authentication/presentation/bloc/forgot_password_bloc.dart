import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(RequestResetState()) {
    on<RequestResetEvent>((event, emit) {
      emit(RequestResetState());
    });

    on<ConfirmCodeEvent>((event, emit) {
      emit(ConfirmCodeState());
    });

    on<ResetPasswordEvent>((event, emit) {
      emit(ResetPasswordState());
    });

    on<GoBackEvent>((event, emit) {
      if (state is ConfirmCodeState) {
        emit(RequestResetState());
      } else if (state is ResetPasswordState) {
        emit(ConfirmCodeState());
      }
    });
  }
}
