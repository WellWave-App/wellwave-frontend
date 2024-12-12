import 'package:wellwave_frontend/features/profile/data/models/profile_request_model.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final ProfileRequestModel userProfile;

  ProfileLoaded(this.userProfile);

  List<Object?> get props => [userProfile];
}


class ProfileEdited extends ProfileState {}

class ProfileError extends ProfileState {
  final String errorMessage;
  ProfileError(this.errorMessage);
}
