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

          final isEdited = await profileRepositories.editUserRequest(
            uid: uid,
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
      emit(ProfileLoading());
      try {
        final userProfile = await profileRepositories.getUSer();

        if (userProfile == null) {
          emit(ProfileError('User profile not found image'));
        } else {
          final uid = userProfile.uid;

          final success = await profileRepositories.uploadProfileImage(
              event.imageFile, uid);

          if (success != null) {
            if (state is ProfileLoaded) {
              final currentUserProfile = (state as ProfileLoaded).userProfile;

              final updatedUserProfile =
                  currentUserProfile.copyWith(imageUrl: success);
              emit(ProfileLoaded(updatedUserProfile));
            } else {
              emit(ProfileError("User profile not found image2"));
            }
          } else {
            emit(ProfileError("Failed to upload image"));
          }
        }
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });
  }
}
