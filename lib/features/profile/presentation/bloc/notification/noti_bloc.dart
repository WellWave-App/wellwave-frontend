import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../data/repositories/notification_repositories.dart';
import 'noti_event.dart';
import 'noti_state.dart';

class BedtimeBloc extends Bloc<BedtimeEvent, BedtimeState> {
  final NotificationSettingRepository repository;

  BedtimeBloc(this.repository) : super(BedtimeInitial()) {
    on<CreateBedtimeEvent>((event, emit) async {
      debugPrint('CreateBedtimeEvent received'); // Debugging log

      emit(BedtimeLoading());
      try {
        await repository.createBedtime(
          uid: event.uid,
          isActive: event.isActive,
          bedtime: event.bedtime,
        );
        debugPrint('Bedtime creation successful'); // Debugging log
        emit(BedtimeSuccess());
      } catch (e) {
        debugPrint('Bedtime creation failed: $e'); // Debugging log
        emit(BedtimeFailure(e.toString()));
      }
    });
  }
}
