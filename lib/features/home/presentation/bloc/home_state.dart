part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

class HomeLoadedState extends HomeState {
  final int exp;
  final int gem;
  final String imageUrl;
  final String username;
  final int userGoalStepWeek;
  final int userGoalExTimeWeek;
  final List<int> weeklyAverages;
  final List<String> readNotifications;
  final bool hasNewNotification;

  HomeLoadedState({
    required this.exp,
    required this.gem,
    required this.imageUrl,
    required this.username,
    required this.userGoalStepWeek,
    required this.userGoalExTimeWeek,
    required this.weeklyAverages,
    required this.readNotifications,
    required this.hasNewNotification,
  });

  HomeLoadedState copyWith({
    int? exp,
    int? gem,
    String? imageUrl,
    String? username,
    int? userGoalStepWeek,
    int? userGoalExTimeWeek,
    List<int>? weeklyAverages,
    List<String>? readNotifications,
    bool? hasNewNotification,
  }) {
    return HomeLoadedState(
      exp: exp ?? this.exp,
      gem: gem ?? this.gem,
      imageUrl: imageUrl ?? this.imageUrl,
      username: username ?? this.username,
      userGoalStepWeek: userGoalStepWeek ?? this.userGoalStepWeek,
      userGoalExTimeWeek: userGoalExTimeWeek ?? this.userGoalExTimeWeek,
      weeklyAverages: weeklyAverages ?? this.weeklyAverages,
      readNotifications: readNotifications ?? this.readNotifications,
      hasNewNotification: hasNewNotification ?? this.hasNewNotification,
    );
  }

  @override
  String toString() {
    return 'HomeLoadedState(exp: $exp, gem: $gem, hasNewNotification: $hasNewNotification)';
  }
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