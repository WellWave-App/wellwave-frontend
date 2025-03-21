import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:wellwave_frontend/features/exchange/data/repositories/exchange_repositories.dart';
import 'package:wellwave_frontend/features/exchange/presentation/bloc/exchange_state.dart';

import '../../data/models/exchange_request_models.dart';
import '../../data/models/exchange_response_models.dart';
import 'exchange_event.dart';

class ExchangeBloc extends Bloc<ExchangeEvent, ExchangeState> {
  final ExchangeRepositories exchangeRepositories;

  ExchangeBloc({required this.exchangeRepositories})
      : super(const ExchangeInitial()) {
    on<FetchUserItemEvent>(_onFetchUserItem);
    on<FetchAllItemEvent>(_onFetchAllItem);
    on<BuyItemEvent>(_onBuyItem);
    on<OpenMysteryBoxEvent>(_onOpenMysteryBox);
    on<ActiveItemEvent>(_onActiveItem);
    // on<RestoreExchangeItemsEvent>(_onRestoreExchangeItems);
  }

  Future<void> _onFetchUserItem(
    FetchUserItemEvent event,
    Emitter<ExchangeState> emit,
  ) async {
    emit(const ExchangeUserItemLoading());
    try {
      final userExchange = await exchangeRepositories.getUserItem();

      // debugPrint("UserExchange Data: $userExchange");

      if (userExchange == null || userExchange.items.isEmpty) {
        debugPrint("No user items found.");
        emit(const ExchangeError('ไม่พบไอเทม'));
        return;
      }

      // debugPrint("Fetched \${userExchange.items.length} items.");
      emit(ExchangeUserItemLoaded(userExchange));
    } catch (e) {
      debugPrint("Error fetching user items: \${e.toString()}");
      emit(const ExchangeError('Error: \${e.toString()}'));
    }
  }

  Future<void> _onFetchAllItem(
    FetchAllItemEvent event,
    Emitter<ExchangeState> emit,
  ) async {
    emit(const ExchangeLoading());
    // debugPrint("Fetching all exchange items...");

    try {
      final userExchange = await exchangeRepositories.getAllItem();

      // debugPrint("UserExchange Data: $userExchange");

      if (userExchange == null || userExchange.items.isEmpty) {
        debugPrint("No exchange items found.");
        emit(const ExchangeError('No exchange items found.'));
        return;
      }

      // debugPrint("Fetched \${userExchange.items.length} items.");
      emit(ExchangeLoaded(userExchange));
    } catch (e) {
      debugPrint("Error fetching items: \${e.toString()}");
      emit(const ExchangeError('Error: \${e.toString()}'));
    }
  }

  Future<void> _onBuyItem(
    BuyItemEvent event,
    Emitter<ExchangeState> emit,
  ) async {
    emit(const ExchangeLoading());

    try {
      final result = await exchangeRepositories.buyItem(
        itemId: event.itemId,
      );

      final exchangeRequest =
          ExchangeResponseModels.fromJson(result as Map<String, dynamic>);

      emit(ExchangeLoaded(exchangeRequest));
    } catch (e) {
      emit(const ExchangeError('Error buying item'));
    }
  }

  Future<void> _onOpenMysteryBox(
    OpenMysteryBoxEvent event,
    Emitter<ExchangeState> emit,
  ) async {
    // Capture current exchange items if available
    ExchangeResponseModels? currentItems;
    if (state is ExchangeLoaded) {
      currentItems = (state as ExchangeLoaded).userExchange;
    }

    // We'll use a different state specifically for mystery box loading
    emit(const MysteryBoxLoading());

    try {
      final result = await exchangeRepositories.openMysteryBox(
        boxName: "main",
      );

      final exchangeRequest =
          ExchangeRequestModels.fromJson(result as Map<String, dynamic>);

      final itemName = exchangeRequest.item.itemName;
      final description = exchangeRequest.item.description;
      final itemType = exchangeRequest.item.itemType;
      final userItemId = exchangeRequest.userItemId;
      final boostMultiplier = exchangeRequest.item.expBooster?.boostMultiplier;
      final gemReward = exchangeRequest.item.gemExchange?.gemReward;
      final boostDays = exchangeRequest.item.expBooster?.boostDays;

      // Include the current items in the MysteryBoxOpened state
      emit(MysteryBoxOpened(itemName, description, itemType, userItemId,
          boostMultiplier, gemReward, boostDays,
          previousExchangeItems: currentItems));
    } catch (e) {
      // If error, restore previous exchange items if available
      if (currentItems != null) {
        emit(ExchangeLoaded(currentItems));
      } else {
        emit(const ExchangeError('Error opening mystery box'));
      }
    }
  }

  Future _onActiveItem(ActiveItemEvent event, Emitter emit) async {
    emit(const ExchangeUserItemLoading());

    try {
      await exchangeRepositories.activeItem(
        userItemId: event.userItemId,
      );

      final exchangeRequest = await exchangeRepositories.getUserItem();

      if (exchangeRequest != null) {
        emit(ExchangeUserItemLoaded(exchangeRequest));
      } else {
        emit(const ExchangeError('Failed to load user items after activation'));
      }
    } catch (e) {
      emit(ExchangeError('Error: ${e.toString()}'));
    }
  }
}
