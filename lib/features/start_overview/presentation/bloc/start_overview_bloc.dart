import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
part 'start_overview_event.dart';
part 'start_overview_state.dart';

class StartOverviewBloc extends Bloc<StartOverviewEvent, StartOverviewState> {
  StartOverviewBloc() : super(PageNavigationState(currentIndex: 0)) {
    on<NextPageEvent>(_onNextPage);
    on<PreviousPageEvent>(_onPreviousPage);
  }

  void _onNextPage(NextPageEvent event, Emitter<StartOverviewState> emit) {
    try {
      if (state is PageNavigationState) {
        final currentIndex = (state as PageNavigationState).currentIndex;

        emit(PageNavigationState(currentIndex: currentIndex + 1));
      }
    } catch (e) {
      if (state is PageNavigationState) {
        emit(PageNavigationErrorState(
            (state as PageNavigationState).currentIndex, e.toString()));
      } else {
        emit(PageNavigationErrorState(0, e.toString()));
      }
    }
  }

  void _onPreviousPage(
      PreviousPageEvent event, Emitter<StartOverviewState> emit) {
    try {
      if (state is PageNavigationState) {
        final currentIndex = (state as PageNavigationState).currentIndex;

        if (currentIndex <= 0) {
          throw Exception("Cannot navigate further.");
        }

        emit(PageNavigationState(currentIndex: currentIndex - 1));
      }
    } catch (e) {
      if (state is PageNavigationState) {
        emit(PageNavigationErrorState(
            (state as PageNavigationState).currentIndex, e.toString()));
      } else {
        emit(PageNavigationErrorState(0, e.toString()));
      }
    }
  }
}
