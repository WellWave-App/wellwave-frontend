import 'package:equatable/equatable.dart';

abstract class FriendEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchFriendEvent extends FriendEvent {
  final String searchId;

  SearchFriendEvent(this.searchId);
}

class ResetEvent extends FriendEvent {}

class ActionFriendProfileEvent extends FriendEvent {}

class ToggleAddfriendButtonEvent extends FriendEvent {
  final String searchId;

  ToggleAddfriendButtonEvent({required this.searchId});
}

class ToggleWaveIconEvent extends FriendEvent {}

class UnfriendButtonEvent extends FriendEvent {
  final String searchId;

  UnfriendButtonEvent({required this.searchId});
}

class FetchFriendProfileEvent extends FriendEvent {
  final int uid;

  FetchFriendProfileEvent({required this.uid});
}

class LoadFriendEvent extends FriendEvent {
  final String friendUid;
  final String selectedPeriod;
  final DateTime? fromDate;
  final DateTime? toDate;

  LoadFriendEvent({
    required this.friendUid,
    required this.selectedPeriod,
    this.fromDate,
    this.toDate,
  });
}
