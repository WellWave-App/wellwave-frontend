import 'dart:io';
import 'package:wellwave_frontend/features/profile/data/models/profile_request_model.dart';

// abstract class ProfileState {
  
// }

class ProfileState {
  final File? selectedImage;

  ProfileState({this.selectedImage});

  ProfileState copyWith({File? selectedImage}) {
    return ProfileState(
      selectedImage: selectedImage ?? this.selectedImage,
    );
  }
}


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

class ProfileSelectImageState extends ProfileState {
  @override
  final File? selectedImage;

  ProfileSelectImageState({
    this.selectedImage,
  });

  @override
  ProfileSelectImageState copyWith({
    File? selectedImage,
  }) {
    return ProfileSelectImageState(
      selectedImage: selectedImage ?? this.selectedImage,
    );
  }

  List<Object?> get props => [ selectedImage];
}
