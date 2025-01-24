part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

class HomeLoadedState extends HomeState {
  final List<int> weeklyAverages;

  HomeLoadedState(this.weeklyAverages);
}

class HomeErrorState extends HomeState {
  final String errorMessage;

  HomeErrorState(this.errorMessage);
}

class HomeUpdated extends HomeState {
  final Map<String, Map<DateTime, bool>> completionStatus;

  HomeUpdated({required this.completionStatus});
}

// class GreetingAndHealthDataState extends HomeState {
//   final String greeting;
//   final String dailyText;
//   final List<int> weeklyAverages;

//   GreetingAndHealthDataState({
//     required this.greeting,
//     required this.dailyText,
//     required this.weeklyAverages,
//   });
// }