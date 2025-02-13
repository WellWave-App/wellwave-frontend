import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/models/auth_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(RequestResetState()) {
    on<CheckLoginStatusEvent>(_onCheckLoginStatus);
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
    on<LogoutEvent>(_onLogout);

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

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading()); // เปลี่ยนจาก AuthInitialEvent() เป็น AuthLoading()

    try {
      final isSuccess = await authRepository.register(
        AuthModel(email: event.email, password: event.password),
      );

      if (isSuccess) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true); // บันทึกสถานะล็อกอิน

        emit(Authenticated()); // เปลี่ยนสถานะเป็นล็อกอินสำเร็จ
      } else {
        emit(AuthFailure(message: "fail", statusCode: 401));
      }
    } catch (e) {
      emit(AuthFailure(message: "$e", statusCode: 500));
    }
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading()); // เปลี่ยนจาก AuthInitialEvent() เป็น AuthLoading()

    try {
      final isSuccess = await authRepository.login(
        AuthModel(email: event.email, password: event.password),
      );

      if (isSuccess) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true); // บันทึกสถานะล็อกอิน
        emit(AuthSuccess(message: "success", statusCode: 201));
        emit(Authenticated()); // เปลี่ยนสถานะเป็นล็อกอินสำเร็จ
      } else {
        emit(AuthFailure(message: "fail", statusCode: 401));
      }
    } catch (e) {
      emit(AuthFailure(message: "$e", statusCode: 500));
    }
  }

  Future<void> _onCheckLoginStatus(
      CheckLoginStatusEvent event, Emitter<AuthState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      emit(Authenticated());
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    emit(Unauthenticated());
  }
}
