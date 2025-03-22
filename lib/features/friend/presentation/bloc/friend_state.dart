import 'package:equatable/equatable.dart';
import 'package:wellwave_frontend/features/friend/data/models/friend_request_model.dart';

abstract class FriendState extends Equatable {
  final String searchId;

  FriendState({this.searchId = ''});

  @override
  List<Object?> get props => [searchId];
}

class FriendInitial extends FriendState {
  FriendInitial() : super(searchId: '');
}

class FriendLoading extends FriendState {
  FriendLoading() : super(searchId: '');
}

class FriendLoaded extends FriendState {
  final FriendRequestModel friends;
  final bool isFriend;

  FriendLoaded(String searchId, this.friends, {this.isFriend = false})
      : super(searchId: searchId);

  @override
  List<Object?> get props => [searchId, friends, isFriend];
}

class FriendError extends FriendState {
  final String message;

  FriendError(this.message) : super(searchId: '');

  @override
  List<Object?> get props => [searchId, message];
}

class FriendShowWaveIcon extends FriendState {
  final bool isWaveActive;

  FriendShowWaveIcon(this.isWaveActive);

  @override
  List<Object?> get props => [searchId, isWaveActive];
}
