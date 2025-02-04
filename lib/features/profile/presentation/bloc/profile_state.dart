import 'dart:io';
import 'package:wellwave_frontend/features/profile/data/models/profile_request_model.dart';

class ProfileState {
  final File? selectedImage;

  ProfileState({this.selectedImage});
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final ProfileRequestModel userProfile;

  @override
  final File? selectedImage;

  ProfileLoaded(this.userProfile, {this.selectedImage});
  @override
  List<Object?> get props => [userProfile, selectedImage];
}

class ProfileEdited extends ProfileState {}

class ProfileError extends ProfileState {
  final String errorMessage;
  ProfileError(this.errorMessage);
}
