import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wellwave_frontend/features/friend/data/repositories/friend_repositories.dart';
import 'package:wellwave_frontend/features/friend/presentation/bloc/friend_event.dart';
import 'package:wellwave_frontend/features/friend/presentation/bloc/friend_state.dart';
import 'package:wellwave_frontend/features/friend/presentation/widget/profile_user_add.dart';
import 'package:wellwave_frontend/features/profile/data/repositories/profile_repositories.dart';

class FriendBloc extends Bloc<FriendEvent, FriendState> {
  final FriendRepositories friendRepositories;
  final ProfileRepositories? profileRepositories;

  FriendBloc({required this.friendRepositories, this.profileRepositories})
      : super(FriendInitial()) {
    on<SearchFriendEvent>(_onSearchFriend);
    on<ResetEvent>(_onReset);
    on<ToggleAddfriendButtonEvent>(_onAddFriend);
    on<UnfriendButtonEvent>(_onUnfriend);
    on<LoadFriendEvent>(_onLoadFriend);
    on<ToggleWaveIconEvent>(_onToggleWaveIcon);
    _loadWaveStatus();
  }
  void _onLoadFriend(LoadFriendEvent event, Emitter<FriendState> emit) async {
    emit(FriendLoading());
    try {
      final userId = int.tryParse(event.friendUid) ?? -1;
      if (userId == -1) {
        emit(FriendError('Invalid user ID'));
        return;
      }

      final friend = await friendRepositories.getFriendProfile(
        userId,
        fromDate: event.fromDate,
        toDate: event.toDate,
      );

      if (friend == null) {
        emit(FriendError('User not found'));
        return;
      }

      emit(FriendLoaded(event.friendUid, friend));
    } catch (e) {
      emit(FriendError('Error: $e'));
    }
  }

  void _onSearchFriend(
      SearchFriendEvent event, Emitter<FriendState> emit) async {
    if (event.searchId.isEmpty) {
      emit(FriendError('Please enter ID'));
      return;
    }

    emit(FriendLoading());
    try {
      final userId = int.tryParse(event.searchId) ?? -1;
      if (userId == -1) {
        emit(FriendError('ID is invalid'));
        return;
      }

      final myUID = await profileRepositories?.getUSer();

      if (myUID?.uid == userId) {
        emit(FriendError('Cannot add yourself'));
        return;
      }

      final friends = await friendRepositories.getUserById(userId);
      if (friends == null) {
        emit(FriendError('User Not found'));
        return;
      }

      final userFriends = await friendRepositories.getUserFriends();
      final isFriend = userFriends.any((friend) => friend['UID'] == userId);

      emit(FriendLoaded(event.searchId, friends, isFriend: isFriend));
    } catch (e) {
      emit(FriendError('Error: $e'));
    }
  }

  void _onAddFriend(
      ToggleAddfriendButtonEvent event, Emitter<FriendState> emit) async {
    emit(FriendLoading());
    try {
      final addFriend =
          await friendRepositories.addFriend(int.parse(event.searchId));
      if (addFriend != null) {
        final updatedUser =
            await friendRepositories.getUserById(int.parse(event.searchId));
        if (updatedUser != null) {
          emit(FriendLoaded(event.searchId, updatedUser, isFriend: true));
        } else {
          emit(FriendError('Failed to fetch updated user data'));
        }
      } else {
        emit(FriendError('Cannot add friend'));
      }
    } catch (e) {
      emit(FriendError('Error: $e'));
    }
  }

  void _onUnfriend(UnfriendButtonEvent event, Emitter<FriendState> emit) async {
    emit(FriendLoading());
    try {
      final unfriend =
          await friendRepositories.unFriend(int.parse(event.searchId));
      if (unfriend != null) {
        final updatedUser =
            await friendRepositories.getUserById(int.parse(event.searchId));
        if (updatedUser != null) {
          emit(FriendLoaded(event.searchId, updatedUser, isFriend: false));
        } else {
          emit(FriendError('Failed to fetch updated user data'));
        }
      } else {
        emit(FriendError('cant unfriend'));
      }
    } catch (e) {
      emit(FriendError('Error: $e'));
    }
  }

  void _onReset(ResetEvent event, Emitter<FriendState> emit) {
    emit(FriendInitial());
    _loadWaveStatus();
  }

  void _onToggleWaveIcon(
      ToggleWaveIconEvent event, Emitter<FriendState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    String today = DateTime.now().toString().split(" ")[0];

    String? lastGreetDate = prefs.getString("last_greet_date");
    bool hasGreetedToday = lastGreetDate == today;

    if (!hasGreetedToday) {
      await prefs.setString("last_greet_date", today);
      await prefs.setBool("has_greeted", true);
      emit(FriendShowWaveIcon(true));
    }
  }

  void _loadWaveStatus() async {
    final prefs = await SharedPreferences.getInstance();
    String today = DateTime.now().toString().split(" ")[0];

    String? lastGreetDate = prefs.getString("last_greet_date");
    bool hasGreetedToday = lastGreetDate == today;

    emit(FriendShowWaveIcon(hasGreetedToday));
  }
}
