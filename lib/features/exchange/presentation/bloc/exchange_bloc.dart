import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:wellwave_frontend/features/exchange/data/repositories/exchange_repositories.dart';
import 'package:wellwave_frontend/features/exchange/presentation/bloc/exchange_state.dart';

import '../../data/models/exchange_request_models.dart';
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
  }

  Future<void> _onFetchUserItem(
    FetchUserItemEvent event,
    Emitter<ExchangeState> emit,
  ) async {
    emit(const ExchangeLoading());
    try {
      final userExchange = await exchangeRepositories.getUserItem();
      if (userExchange == null) {
        emit(const ExchangeError('User item not found'));
      } else {
        emit(ExchangeLoaded(userExchange));
      }
    } catch (e) {
      emit(ExchangeError(e.toString()));
    }
  }

  Future<void> _onFetchAllItem(
    FetchAllItemEvent event,
    Emitter<ExchangeState> emit,
  ) async {
    emit(const ExchangeLoading());
    debugPrint("Fetching all exchange items...");

    try {
      final userExchange = await exchangeRepositories.getAllItem();

      debugPrint("UserExchange Data: $userExchange");

      if (userExchange == null || userExchange.items.isEmpty) {
        debugPrint("No exchange items found.");
        emit(const ExchangeError('No exchange items found.'));
        return;
      }

      debugPrint("Fetched \${userExchange.items.length} items.");
      emit(ExchangeLoaded(userExchange));
    } catch (e) {
      debugPrint("Error fetching items: \${e.toString()}");
      emit(ExchangeError('Error: \${e.toString()}'));
    }
  }

  Future<void> _onBuyItem(
    BuyItemEvent event,
    Emitter<ExchangeState> emit,
  ) async {
    if (state is ExchangeLoaded) {
      final currentState = state as ExchangeLoaded;
      emit(currentState);
    }
  }

  Future<void> _onOpenMysteryBox(
    OpenMysteryBoxEvent event,
    Emitter<ExchangeState> emit,
  ) async {
    emit(const ExchangeLoading());

    try {
      // Fetch the mystery box content
      final result = await exchangeRepositories.openMysteryBox(
        boxName: "main",
      );

      if (result == null) {
        throw Exception("Failed to open mystery box");
      }

      // Parse the result into the model
      final exchangeRequest =
          ExchangeRequestModels.fromJson(result as Map<String, dynamic>);

      // Extract item details
      final item = exchangeRequest.items.first.item;
      final itemName = item.itemName;
      final description = item.description;
      final itemType = item.itemType;
      final userItemId = exchangeRequest.items.first.userItemId;

      // Emit ExchangeLoaded with item details
      emit(ExchangeLoaded(
        exchangeRequest,
        itemName: itemName,
        description: description,
        itemType: itemType,
        userItemId: userItemId,
      ));
    } catch (e) {
      emit(ExchangeError('Error: \${e.toString()}'));
    }
  }

  Future<void> _onActiveItem(
    ActiveItemEvent event,
    Emitter<ExchangeState> emit,
  ) async {
    emit(const ExchangeLoading());

    try {
      final result = await exchangeRepositories.activeItem(
        userItemId: event.userItemId,
      );

      // Parse the response into the updated model
      final exchangeRequest =
          ExchangeRequestModels.fromJson(result as Map<String, dynamic>);

      if (exchangeRequest.items.isNotEmpty) {
        // Extract item details
        final item = exchangeRequest.items.first.item;
        final itemName = item.itemName;
        final description = item.description;
        final itemType = item.itemType;
        final userItemId = exchangeRequest.items.first.userItemId;

        // Emit ExchangeLoaded with item details
        emit(ExchangeLoaded(
          exchangeRequest,
          itemName: itemName,
          description: description,
          itemType: itemType,
          userItemId: userItemId,
        ));
      } else {
        emit(const ExchangeError("No item found for activation"));
      }
    } catch (e) {
      emit(ExchangeError('Error: ${e.toString()}'));
    }
  }
}
