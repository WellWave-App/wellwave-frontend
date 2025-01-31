import 'package:equatable/equatable.dart';

abstract class FriendEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchFriendEvent extends FriendEvent {
  final String searchId;

  SearchFriendEvent(this.searchId);

  @override
  List<Object?> get props => [searchId];
}

class ResetEvent extends FriendEvent {}

class ToggleUnfriendButtonEvent extends FriendEvent {}
