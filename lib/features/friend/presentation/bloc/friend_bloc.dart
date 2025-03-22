import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wellwave_frontend/features/friend/data/models/friend_request_model.dart';
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
    on<LoadFriendsEvent>(_onLoadFriends);
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
      final allFriends = await friendRepositories.getUserFriends();

      if (friend == null) {
        emit(FriendError('User not found'));
        return;
      }

      emit(FriendLoaded(event.friendUid, friend, allFriends));
    } catch (e) {
      emit(FriendError('Error: $e'));
    }
  }

  void _onLoadFriends(LoadFriendsEvent event, Emitter<FriendState> emit) async {
    emit(FriendLoading());
    try {
      final friends = await friendRepositories.getUserFriends();
      if (friends != null) {
        final emptyFriend = FriendRequestModel(
          uid: 0,
          username: '',
          imageUrl: '',
          lastLogin: '',
          stepsLog: [],
          sleepLog: [],
          exp: 0,
          gem: 0,
          league: 'none',
        );
        emit(FriendLoaded('', emptyFriend, friends));
      } else {
        emit(FriendError('Failed to load friends'));
      }
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
      final isFriend =
          userFriends?.data.any((friend) => friend.uid == userId) ?? false;

      emit(FriendLoaded(event.searchId, friends, userFriends,
          isFriend: isFriend));
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
        final allFriends = await friendRepositories.getUserFriends();
        final updatedUser =
            await friendRepositories.getUserById(int.parse(event.searchId));
        if (updatedUser != null) {
          emit(FriendLoaded(event.searchId, updatedUser, allFriends,
              isFriend: true));
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
        final friends = await friendRepositories.getUserFriends();
        emit(FriendLoaded('', unfriend, friends));
      } else {
        emit(FriendError('Cannot unfriend'));
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
    if (state is FriendLoaded) {
      final currentState = state as FriendLoaded;
      final prefs = await SharedPreferences.getInstance();
      String today = DateTime.now().toString().split(" ")[0];

      await prefs.setString("last_greet_date", today);
      await prefs.setBool("has_greeted", true);

      emit(FriendLoaded(
        currentState.searchId,
        currentState.friends,
        currentState.allFriends,
        isFriend: currentState.isFriend,
        isWaveActive: true,
      ));
    }
  }

  void _loadWaveStatus() async {
    if (state is FriendLoaded) {
      final currentState = state as FriendLoaded;
      final prefs = await SharedPreferences.getInstance();
      String today = DateTime.now().toString().split(" ")[0];

      String? lastGreetDate = prefs.getString("last_greet_date");
      bool hasGreetedToday = lastGreetDate == today;

      emit(FriendLoaded(
        currentState.searchId,
        currentState.friends,
        currentState.allFriends,
        isFriend: currentState.isFriend,
        isWaveActive: hasGreetedToday,
      ));
    }
  }
}
