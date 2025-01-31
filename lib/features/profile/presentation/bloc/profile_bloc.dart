import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
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
        final userProfile = await profileRepositories.getUSer();
        if (userProfile == null) {
          emit(ProfileError('User profile not found fetch'));
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
        final userProfile = await profileRepositories.getUSer();

        if (userProfile == null) {
          emit(ProfileError('User profile not found edit'));
        } else {
          final uid = userProfile.uid;

          // Use the existing imageUrl if no new imageUrl is provided
          final updatedImageUrl = event.imageUrl ?? userProfile.imageUrl;

          final isEdited = await profileRepositories.editUserRequest(
            uid: uid,
            imageUrl: updatedImageUrl, // Use the updated imageUrl
            username: event.username,
            yearOfBirth: event.yearOfBirth,
            gender: event.gender,
            height: event.height,
            weight: event.weight,
          );

          if (isEdited) {
            // Fetch the updated profile to ensure the state is up-to-date
            final updatedUserProfile = await profileRepositories.getUSer();
            if (updatedUserProfile != null) {
              emit(ProfileLoaded(updatedUserProfile));
            } else {
              emit(ProfileError("Failed to fetch updated profile"));
            }
          } else {
            emit(ProfileError("Failed to edit profile"));
          }
        }
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });

    on<EditUserGoalPerWeek>((event, emit) async {
      emit(ProfileLoading());
      try {
        final userProfile = await profileRepositories.getUSer();

        if (userProfile == null) {
          emit(ProfileError('User profile not found goal'));
        } else {
          final uid = userProfile.uid;

          final isEdited = await profileRepositories.setGoalPerWeek(
              uid: uid,
              stepPerWeek: event.stepPerWeek,
              exercisePerWeek: event.exercisePerWeek);

          if (isEdited) {
            emit(ProfileEdited());
          } else {
            emit(ProfileError("Failed to edit user goal per week"));
          }
        }
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });

    on<ImagePicked>((event, emit) async {
      try {
        // First emit loading state
        emit(ProfileLoading());

        // Debug debugPrint
        debugPrint('Processing ImagePicked event');
        debugPrint('Image file path: ${event.imageFile.path}');

        // Get current user profile
        final userProfile = await profileRepositories.getUSer();
        if (userProfile == null) {
          throw Exception('User profile not found');
        }

        // Upload image
        debugPrint('Uploading image for UID: ${userProfile.uid}');
        final imageUrl = await profileRepositories.uploadProfileImage(
          event.imageFile,
          userProfile.uid,
        );

        if (imageUrl == null) {
          throw Exception('Failed to get image URL from server');
        }

        debugPrint('Successfully got image URL: $imageUrl');

        // Create updated profile
        final updatedUserProfile = userProfile.copyWith(imageUrl: imageUrl);

        // Emit success state
        emit(ProfileLoaded(
          updatedUserProfile,
          selectedImage: event.imageFile,
        ));
      } catch (e, stackTrace) {
        debugPrint('Error in ImagePicked event handler: $e');
        debugPrint('Stack trace: $stackTrace');
        emit(ProfileError(e.toString()));
      }
    });
  }
}
