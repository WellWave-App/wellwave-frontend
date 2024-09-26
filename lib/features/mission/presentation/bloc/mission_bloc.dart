import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'mission_event.dart';
part 'mission_state.dart';

class MissionBloc extends Bloc<MissionEvent, MissionState> {
  MissionBloc() : super(MissionInitial()) {
    on<IncrementDailyCountEvent>(_onIncreaseDailyCount);
    on<DecrementDailyCountEvent>(_onDecreaseDailyCount);
    on<IncrementMinuteCountEvent>(_onIncreaseMinuteCount);
    on<DecrementMinuteCountEvent>(_onDecreaseMinuteCount);
    on<ConfirmGoalEvent>(_onConfirmGoal);
    on<ResetGoalEvent>(_onResetGoal);
    on<CompleteTaskEvent>(_onCompleteTaskEvent);
  }

  void _onIncreaseDailyCount(
      IncrementDailyCountEvent event, Emitter<MissionState> emit) {
    if (state is HabitChallengeState) {
      final currentState = state as HabitChallengeState;
      if (currentState.dailyCount < 7) {
        emit(HabitChallengeState(
          dailyCount: currentState.dailyCount + 1,
          minuteCount: currentState.minuteCount,
        ));
      }
    } else {
      emit(HabitChallengeState(dailyCount: 1, minuteCount: 5));
    }
  }

  void _onDecreaseDailyCount(
      DecrementDailyCountEvent event, Emitter<MissionState> emit) {
    if (state is HabitChallengeState) {
      final currentState = state as HabitChallengeState;
      if (currentState.dailyCount > 1) {
        emit(HabitChallengeState(
          dailyCount: currentState.dailyCount - 1,
          minuteCount: currentState.minuteCount,
        ));
      }
    }
  }

  void _onIncreaseMinuteCount(
      IncrementMinuteCountEvent event, Emitter<MissionState> emit) {
    if (state is HabitChallengeState) {
      final currentState = state as HabitChallengeState;
      emit(HabitChallengeState(
        dailyCount: currentState.dailyCount,
        minuteCount: currentState.minuteCount + event.incrementBy,
      ));
    } else {
      emit(HabitChallengeState(dailyCount: 1, minuteCount: 5));
    }
  }

  void _onDecreaseMinuteCount(
      DecrementMinuteCountEvent event, Emitter<MissionState> emit) {
    if (state is HabitChallengeState) {
      final currentState = state as HabitChallengeState;
      if (currentState.minuteCount > event.decrementBy) {
        emit(HabitChallengeState(
          dailyCount: currentState.dailyCount,
          minuteCount: currentState.minuteCount - event.decrementBy,
        ));
      }
    }
  }

  void _onConfirmGoal(ConfirmGoalEvent event, Emitter<MissionState> emit) {
    emit(HabitChallengeState(
      dailyCount: event.dailyCount,
      minuteCount: event.minuteCount,
    ));
  }

  void _onResetGoal(ResetGoalEvent event, Emitter<MissionState> emit) {
    emit(HabitChallengeState(
        dailyCount: 1, minuteCount: 5)); // Reset to defaults
  }

  void _onCompleteTaskEvent(
      CompleteTaskEvent event, Emitter<MissionState> emit) {
    emit(TaskCompletedState(isCompleted: true));
    debugPrint("Task completed. Emitting TaskCompletedState");
  }
}
