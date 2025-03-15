import 'package:wellwave_frontend/features/exchange/data/models/exchange_request_models.dart';

abstract class ExchangeState {
  const ExchangeState();
}

class ExchangeInitial extends ExchangeState {
  const ExchangeInitial() : super();
}

class ExchangeLoading extends ExchangeState {
  const ExchangeLoading() : super();
}

class ExchangeLoaded extends ExchangeState {
  final ExchangeRequestModels userExchange;
  final String? itemName;
  final String? description;
  final String? itemType;
  final int? userItemId;

  const ExchangeLoaded(
    this.userExchange, {
    this.itemName,
    this.description,
    this.itemType,
    this.userItemId,
  }) : super();
}

class ExchangeError extends ExchangeState {
  final String errorMessage;

  const ExchangeError(this.errorMessage) : super();
}

// class ExchangeOpened extends ExchangeState {
//   final String itemName;
//   final String description;
//   final String itemType;
//   final int userItemId;
//   const ExchangeOpened(
//       this.itemName, this.description, this.itemType, this.userItemId);
// }
