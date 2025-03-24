import 'package:bloc/bloc.dart';
import 'package:wellwave_frontend/features/mission/data/models/habit_request_model.dart';
import 'package:wellwave_frontend/features/mission/data/models/rec_habit_respone_model.dart';
import 'package:wellwave_frontend/features/mission/data/repositories/habit_repositories.dart';
part 'mission_event.dart';
part 'mission_state.dart';

class MissionBloc extends Bloc<MissionEvent, MissionState> {
  final HabitRepositories habitRepositories;

  MissionBloc({
    required this.habitRepositories,
  }) : super(MissionInitial()) {
    on<IncrementDailyCountEvent>(_onIncreaseDailyCount);
    on<DecrementDailyCountEvent>(_onDecreaseDailyCount);
    on<IncrementMinuteCountEvent>(_onIncreaseMinuteCount);
    on<DecrementMinuteCountEvent>(_onDecreaseMinuteCount);
    on<ConfirmGoalEvent>(_onConfirmGoal);
    on<ResetGoalEvent>(_onResetGoal);
    on<CompleteTaskEvent>(_onCompleteTaskEvent);
    on<StartProgressEvent>(_onStartProgress);
    on<LoadHabitsEvent>(_onLoadHabits);
    on<LoadRecHabitsEvent>(_onLoadRecHabits); // Add this line
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
    emit(HabitChallengeState(dailyCount: 1, minuteCount: 5));
  }

  void _onCompleteTaskEvent(
      CompleteTaskEvent event, Emitter<MissionState> emit) {
    if (state is DailyTaskState) {
      final currentState = state as DailyTaskState;
      final updatedCompletedTaskIds =
          List<int>.from(currentState.completedTaskIds);

      if (!updatedCompletedTaskIds.contains(event.taskId)) {
        updatedCompletedTaskIds.add(event.taskId);
      }

      emit(DailyTaskState(completedTaskIds: updatedCompletedTaskIds));
    } else {
      emit(DailyTaskState(completedTaskIds: [event.taskId]));
    }
  }

  void _onStartProgress(StartProgressEvent event, Emitter<MissionState> emit) {
    emit(ProgressState());
  }

  void _onLoadHabits(LoadHabitsEvent event, Emitter<MissionState> emit) async {
    emit(HabitLoading());
    try {
      final habits =
          await habitRepositories.getHabitAll(category: event.category);
      if (habits != null) {
        emit(HabitLoaded(habits, null)); // Pass null for recHabits
      } else {
        emit(const HabitError('Failed to load habits'));
      }
    } catch (e) {
      emit(HabitError('Error loading habits: $e'));
    }
  }

  void _onLoadRecHabits(
      LoadRecHabitsEvent event, Emitter<MissionState> emit) async {
    emit(HabitLoading());
    try {
      final recHabits = await habitRepositories.getRecHabit();
      print('Received recHabits: $recHabits'); // Debug print

      if (recHabits != null) {
        final emptyHabits = HabitRequestModel(
            habits: [], meta: HabitMetaRequestModel(total: 0));
        emit(HabitLoaded(emptyHabits, recHabits));
      } else {
        print('RecHabits is null'); // Debug print
        emit(const HabitError(
            'Failed to load recommended habits - null response'));
      }
    } catch (e, stackTrace) {
      print('Error in _onLoadRecHabits: $e'); // Debug print
      print('Stack trace: $stackTrace'); // Debug print
      emit(HabitError('Error loading recommended habits: $e'));
    }
  }
}
