part of 'start_overview_bloc.dart';

@immutable
abstract class StartOverviewState {}

class StartOverviewInitial extends StartOverviewState {}

class PageNavigationState extends StartOverviewState {
  final int currentIndex;

  PageNavigationState({required this.currentIndex});
}

class PageNavigationErrorState extends StartOverviewState {
  final int currentIndex;
  final String errorMessage;

  PageNavigationErrorState(this.currentIndex, this.errorMessage);
}
