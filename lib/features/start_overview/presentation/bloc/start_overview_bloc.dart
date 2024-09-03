import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'start_overview_event.dart';
part 'start_overview_state.dart';

class StartOverviewBloc extends Bloc<StartOverviewEvent, StartOverviewState> {
  StartOverviewBloc() : super(StartOverviewInitial()) {
    on<StartOverviewEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
