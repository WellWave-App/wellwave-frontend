import 'package:bloc/bloc.dart';

import 'package:wellwave_frontend/features/profile/data/repositories/profile_repositories.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepositories profileRepositories;

  ProfileBloc({required this.profileRepositories}) : super(ProfileInitial()) {
    // Fetch user profile
    on<FetchUserProfile>((event, emit) async {
      emit(ProfileLoading());
      try {
        final userProfile = await profileRepositories.getUserById(event.uid);
        if (userProfile == null) {
          emit(ProfileError('User profile not found for UID: ${event.uid}'));
        } else {
          emit(ProfileLoaded(userProfile));
        }
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });

    // Edit user profile
    on<EditUserProfile>((event, emit) async {
      emit(ProfileLoading());
      try {
        final isEdited = await profileRepositories.editUserRequest(
          uid: event.uid,
          imageUrl: event.imageUrl,
          username: event.username,
          yearOfBirth: event.yearOfBirth,
          gender: event.gender,
          height: event.height,
          weight: event.weight,
        );
        if (isEdited) {
          emit(ProfileEdited());
        } else {
          emit(ProfileError("Failed to edit profile"));
        }
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });

    on<ImagePicked>((event, emit) async {
      if (state is ProfileLoaded) {
        final userProfile = (state as ProfileLoaded).userProfile;
        emit(ProfileLoading());
        try {
        
          final updatedProfile =
              await profileRepositories.getUserById(userProfile.uid);

          if (updatedProfile != null) {
            emit(ProfileLoaded(updatedProfile));
          } else {
            emit(ProfileError("Failed to refresh profile after image upload."));
          }
        } catch (e) {
          emit(ProfileError("Error updating image: ${e.toString()}"));
        }
      } else {
        emit(ProfileError("Cannot update image. User profile is not loaded."));
      }
    });
  }

}
