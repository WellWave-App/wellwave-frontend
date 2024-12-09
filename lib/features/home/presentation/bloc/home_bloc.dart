import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class NavigateToProfileScreenEvent extends HomeEvent {}

class NavigationToProfileScreenState extends HomeState {}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<NavigateToProfileScreenEvent>((event, emit) {
      emit(NavigationToProfileScreenState());
    });
  }
}
