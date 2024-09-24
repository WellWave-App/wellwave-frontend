import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'mission_event.dart';
part 'mission_state.dart';

class MissionBloc extends Bloc<MissionEvent, MissionState> {
  MissionBloc() : super(MissionInitial()) {
    // Habit Challenge Logic
    on<IncrementDailyCount>((event, emit) {
      if (state is HabitChallengeState) {
        final currentState = state as HabitChallengeState;
        emit(HabitChallengeState(
          dailyCount: currentState.dailyCount + 1,
          minuteCount: currentState.minuteCount,
        ));
      } else {
        emit( HabitChallengeState(dailyCount: 2, minuteCount: 1));
      }
    });

    on<DecrementDailyCount>((event, emit) {
      if (state is HabitChallengeState) {
        final currentState = state as HabitChallengeState;
        if (currentState.dailyCount > 1) {
          emit(HabitChallengeState(
            dailyCount: currentState.dailyCount - 1,
            minuteCount: currentState.minuteCount,
          ));
        }
      }
    });

    on<IncrementMinuteCount>((event, emit) {
      if (state is HabitChallengeState) {
        final currentState = state as HabitChallengeState;
        emit(HabitChallengeState(
          dailyCount: currentState.dailyCount,
          minuteCount: currentState.minuteCount + 1,
        ));
      }
    });

    on<DecrementMinuteCount>((event, emit) {
      if (state is HabitChallengeState) {
        final currentState = state as HabitChallengeState;
        if (currentState.minuteCount > 1) {
          emit(HabitChallengeState(
            dailyCount: currentState.dailyCount,
            minuteCount: currentState.minuteCount - 1,
          ));
        }
      }
    });

    // Daily Task Logic
    on<CompleteTaskEvent>((event, emit) {
      try {
        emit(TaskCompletedState());
      } catch (e) {
        emit(MissionInitial());
      }
    });
  }
}