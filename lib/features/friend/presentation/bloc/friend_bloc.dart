import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellwave_frontend/features/friend/data/repositories/friend_repositories.dart';
import 'package:wellwave_frontend/features/friend/presentation/bloc/friend_event.dart';
import 'package:wellwave_frontend/features/friend/presentation/bloc/friend_state.dart';
import 'package:wellwave_frontend/features/profile/data/repositories/profile_repositories.dart';

class FriendBloc extends Bloc<FriendEvent, FriendState> {
  final ProfileRepositories profileRepositories;

  FriendBloc({required this.profileRepositories}) : super(FriendInitial()) {
    on<SearchFriendEvent>(_onSearchFriend);
    on<ResetEvent>(_onReset);
    on<ToggleUnfriendButtonEvent>(_onToggleUnfriendButton);
  }

  void _onSearchFriend(
      SearchFriendEvent event, Emitter<FriendState> emit) async {
    if (event.searchId.isEmpty) {
      emit(FriendError('กรุณากรอกไอดี'));
    } else {
      emit(FriendLoading());
      try {
        final profile =
            await profileRepositories.getUserById(int.parse(event.searchId));
        if (profile != null) {
          emit(FriendLoaded(event.searchId, profile));
        } else {
          emit(FriendError('User Not found'));
        }
      } catch (e) {
        emit(FriendError('Error: $e'));
      }
    }
  }

  void _onReset(ResetEvent event, Emitter<FriendState> emit) {
    emit(FriendInitial());
  }

  void _onToggleUnfriendButton(
      ToggleUnfriendButtonEvent event, Emitter<FriendState> emit) {
    final currentState = state;

    if (currentState is FriendShowUnfriendButton) {
      emit(FriendShowUnfriendButton(!currentState.isVisible));
    } else {
      emit(FriendShowUnfriendButton(true));
    }
  }
}
