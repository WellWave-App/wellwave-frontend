abstract class ExchangeEvent {}

class FetchUserItemEvent extends ExchangeEvent {}

class FetchAllItemEvent extends ExchangeEvent {}

class BuyItemEvent extends ExchangeEvent {
  BuyItemEvent();
}

class OpenMysteryBoxEvent extends ExchangeEvent {
  OpenMysteryBoxEvent();
}
