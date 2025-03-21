import 'package:equatable/equatable.dart';
import 'package:wellwave_frontend/features/profile/data/models/profile_request_model.dart';

abstract class FriendState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FriendInitial extends FriendState {}

class FriendLoading extends FriendState {}

class FriendLoaded extends FriendState {
  final String searchId;
  final ProfileRequestModel profile;

  FriendLoaded(this.searchId, this.profile);
}

class FriendError extends FriendState {
  final String error;

  FriendError(this.error);

  @override
  List<Object?> get props => [error];
}

class FriendShowUnfriendButton extends FriendState {
  final bool isVisible;
  FriendShowUnfriendButton(this.isVisible);

  @override
  List<Object?> get props => [isVisible];
}

class FriendShowWaveIcon extends FriendState {
  final bool isWaveActive;

  FriendShowWaveIcon(this.isWaveActive);

  @override
  List<Object?> get props => [isWaveActive];
}
