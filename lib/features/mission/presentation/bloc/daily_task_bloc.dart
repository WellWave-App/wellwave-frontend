import 'package:bloc/bloc.dart';

part 'daily_task_event.dart';
part 'daily_task_state.dart';

class DailyTaskBloc extends Bloc<DailyTaskEvent, DailyTaskState> {
  DailyTaskBloc() : super(DailyTaskInitial()) {
    on<DailyTaskEvent>((event, emit) {
      try {
        emit(TaskCompletedState());
      } catch (e) {
        emit(DailyTaskInitial());
      }
    });
  }
}
