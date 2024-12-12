import 'package:bloc/bloc.dart';
import 'package:wellwave_frontend/features/profile/data/repositories/profile_repositories.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepositories profileRepositories;

  ProfileBloc({required this.profileRepositories}) : super(ProfileInitial()) {
    on<FetchUserProfile>((event, emit) async {
      emit(ProfileLoading());
      try {
        final userProfile = await profileRepositories.getUserById(event.uid);
        emit(ProfileLoaded(userProfile));
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });

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
  }
}
