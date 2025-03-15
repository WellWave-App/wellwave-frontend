import 'package:bloc/bloc.dart';
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
    try {
      final userExchange = await exchangeRepositories.getAllItem();
      if (userExchange == null) {
        emit(const ExchangeError('Item not found'));
      } else {
        emit(ExchangeLoaded(userExchange));
      }
    } catch (e) {
      emit(ExchangeError(e.toString()));
    }
  }

  Future<void> _onBuyItem(
    BuyItemEvent event,
    Emitter<ExchangeState> emit,
  ) async {
    if (state is ExchangeLoaded) {
      final currentState = state as ExchangeLoaded;
      emit(currentState.copyWith());
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

      // Parse the result into the model
      final exchangeRequest =
          ExchangeRequestModels.fromJson(result as Map<String, dynamic>);

      // Extract itemName and description
      final itemName = exchangeRequest.item.itemName;
      final description = exchangeRequest.item.description;
      final itemType = exchangeRequest.item.itemType;
      final userItemId = exchangeRequest.userItemId;

      emit(ExchangeOpened(itemName, description, itemType, userItemId));
    } catch (e) {
      emit(ExchangeError('Error: ${e.toString()}'));
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

      final exchangeRequest =
          ExchangeRequestModels.fromJson(result as Map<String, dynamic>);

      final userItemId = exchangeRequest.userItemId;
      final itemName = exchangeRequest.item.itemName;
      final description = exchangeRequest.item.description;
      final itemType = exchangeRequest.item.itemType;

      emit(ExchangeOpened(itemName, description, itemType, userItemId));
    } catch (e) {
      emit(ExchangeError('Error: ${e.toString()}'));
    }
  }
}
