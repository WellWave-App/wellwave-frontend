import 'package:flutter/material.dart';

class ExchangeResponseModels {
  final List<ExchangeResponseModel> items;

  ExchangeResponseModels({required this.items});

  factory ExchangeResponseModels.fromJson(Map<String, dynamic> json) {
    final itemsList = json['items'] as List;
    return ExchangeResponseModels(
      items: itemsList
          .map((item) => ExchangeResponseModel.fromJson(item))
          .toList(),
    );
  }
}

class ExchangeResponseModel {
  final int userItemId;
  final int uid;
  final int itemId;
  final DateTime purchaseDate;
  final DateTime? expireDate;
  final bool isActive;
  final Item item;

  const ExchangeResponseModel({
    required this.userItemId,
    required this.uid,
    required this.itemId,
    required this.purchaseDate,
    this.expireDate,
    required this.isActive,
    required this.item,
  });

  factory ExchangeResponseModel.fromJson(Map<String, dynamic> json) {
    debugPrint('Parsing ExchangeResponseModel: $json');

    // Check if the item field exists as expected
    if (json['item'] == null) {
      debugPrint('WARNING: No "item" field found in the JSON: $json');
      // The item data is probably at the root level
    }

    final item = json['item'] != null
        ? Item.fromJson(json['item'])
        : Item.fromJson(
            json); // Try to parse from the root if 'item' is missing

    return ExchangeResponseModel(
      userItemId: json['USER_ITEM_ID'] ?? 0,
      uid: json['UID'] ?? 0,
      itemId: json['ITEM_ID'] ?? 0,
      purchaseDate: json['PURCHASE_DATE'] != null
          ? DateTime.parse(json['PURCHASE_DATE'])
          : DateTime.now(),
      expireDate: json['EXPIRE_DATE'] != null
          ? DateTime.tryParse(json['EXPIRE_DATE'])
          : null,
      isActive: json['IS_ACTIVE'] ?? false,
      item: item,
    );
  }
}

class Item {
  final int itemId;
  final String itemType;
  final String itemName;
  final String description;
  final int priceGem;
  final int priceExp;
  final String? imageUrl;
  final double rarity;
  final bool isActive;
  final ExpBooster? expBooster;
  final GemExchange? gemExchange;
  final List<MysteryBox> mysteryBoxes;

  const Item({
    required this.itemId,
    required this.itemType,
    required this.itemName,
    required this.description,
    required this.priceGem,
    required this.priceExp,
    this.imageUrl,
    required this.rarity,
    required this.isActive,
    this.expBooster,
    this.gemExchange,
    this.mysteryBoxes = const [],
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    debugPrint('Parsing Item: $json');

    // Debug the expBooster and gemExchange
    debugPrint('expBooster data: ${json['expBooster']}');
    debugPrint('gemExchange data: ${json['gemExchange']}');
    debugPrint('ITEM_TYPE data: ${json['ITEM_TYPE']}');

    final itemType = json['ITEM_TYPE'] ?? '';
    final expBooster = json['expBooster'] != null
        ? ExpBooster.fromJson(json['expBooster'])
        : null;
    final gemExchange = json['gemExchange'] != null
        ? GemExchange.fromJson(json['gemExchange'])
        : null;

    debugPrint(
        'Parsed Item - Type: $itemType, ExpBooster: $expBooster, GemExchange: $gemExchange');

    return Item(
      itemId: json['ITEM_ID'] ?? 0,
      itemType: itemType,
      itemName: json['ITEM_NAME'] ?? '',
      description: json['DESCRIPTION'] ?? '',
      priceGem: json['PRICE_GEM'] ?? 0,
      priceExp: json['PRICE_EXP'] ?? 0,
      imageUrl: json['IMAGE_URL'],
      rarity: (json['RARITY'] as num?)?.toDouble() ?? 0.0,
      isActive: json['IS_ACTIVE'] ?? false,
      expBooster: expBooster,
      gemExchange: gemExchange,
      mysteryBoxes: (json['mysteryBoxes'] as List?)
              ?.map((e) => MysteryBox.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class ExpBooster {
  final int itemId;
  final double boostMultiplier;
  final int boostDays;

  const ExpBooster({
    required this.itemId,
    required this.boostMultiplier,
    required this.boostDays,
  });

  factory ExpBooster.fromJson(Map<String, dynamic> json) {
    return ExpBooster(
      itemId: json['ITEM_ID'] ?? 0,
      boostMultiplier: (json['BOOST_MULTIPLIER'] as num?)?.toDouble() ?? 1.0,
      boostDays: json['BOOST_DAYS'] ?? 0,
    );
  }
}

class GemExchange {
  final int itemId;
  final int gemReward;

  const GemExchange({
    required this.itemId,
    required this.gemReward,
  });

  factory GemExchange.fromJson(Map<String, dynamic> json) {
    return GemExchange(
      itemId: json['ITEM_ID'] ?? 0,
      gemReward: json['GEM_REWARD'] ?? 0,
    );
  }
}

class MysteryBox {
  final String boxName;
  final String boxDescription;
  final int? priceGem;
  final int? priceExp;
  final String? imageUrl;
  final bool isActive;

  const MysteryBox({
    required this.boxName,
    required this.boxDescription,
    required this.priceGem,
    required this.priceExp,
    this.imageUrl,
    required this.isActive,
  });

  factory MysteryBox.fromJson(Map<String, dynamic> json) {
    return MysteryBox(
      boxName: json['BOX_NAME'] ?? 'Unknown',
      boxDescription: json['BOX_DESCRIPTION'] ?? '',
      priceGem: (json['PRICE_GEM'] as int?) ?? 0,
      priceExp: (json['PRICE_EXP'] as int?) ?? 0,
      imageUrl: json['IMAGE_URL'],
      isActive: json['IS_ACTIVE'] ?? false,
    );
  }
}
