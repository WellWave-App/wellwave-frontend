import 'package:bloc/bloc.dart';
import 'package:wellwave_frontend/features/profile/data/repositories/archeivement_repositories.dart';

import 'archeivement_event.dart';
import 'archeivement_state.dart';

class ArcheivementBloc extends Bloc<ArcheivementEvent, ArcheivementState> {
  final ArcheivementRepositories archeivementRepositories;

  ArcheivementBloc({required this.archeivementRepositories})
      : super(ArcheivementInitial()) {
    on<FetchArcheivement>(_onFetchArcheivement);
  }

  Future<void> _onFetchArcheivement(
    FetchArcheivement event,
    Emitter<ArcheivementState> emit,
  ) async {
    emit(ArcheivementLoading());
    try {
      final achievements = await archeivementRepositories.getUserArcheivement();
      if (achievements == null) {
        emit(ArcheivementError('Achievements not found'));
      } else {
        emit(ArcheivementLoaded(achievements));
      }
    } catch (e) {
      emit(ArcheivementError(e.toString()));
    }
  }
}
