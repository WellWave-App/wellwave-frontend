class ExchangeRequestModels {
  final List<ExchangeRequestModel> items;

  ExchangeRequestModels({required this.items});

  factory ExchangeRequestModels.fromJson(dynamic json) {
    if (json is List) {
      // Handle case where API returns a list
      return ExchangeRequestModels(
        items: json.map((item) => ExchangeRequestModel.fromJson(item)).toList(),
      );
    } else if (json is Map<String, dynamic>) {
      // Handle case where API returns a single object
      return ExchangeRequestModels(
        items: [ExchangeRequestModel.fromJson(json)],
      );
    } else {
      throw Exception("Unexpected JSON format for ExchangeRequestModels");
    }
  }
}

class ExchangeRequestModel {
  final int userItemId;
  final int uid;
  final int itemId;
  final DateTime purchaseDate;
  final DateTime? expireDate;
  final bool isActive;
  final Item item;

  const ExchangeRequestModel({
    required this.userItemId,
    required this.uid,
    required this.itemId,
    required this.purchaseDate,
    this.expireDate,
    required this.isActive,
    required this.item,
  });

  factory ExchangeRequestModel.fromJson(Map<String, dynamic> json) {
    return ExchangeRequestModel(
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
      item: json['item'] != null
          ? Item.fromJson(json['item'])
          : const Item(
              itemId: 0,
              itemType: '',
              itemName: '',
              description: '',
              priceGem: 0,
              priceExp: 0,
              rarity: 0,
              isActive: false,
            ),
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
    return Item(
      itemId: json['ITEM_ID'],
      itemType: json['ITEM_TYPE'],
      itemName: json['ITEM_NAME'],
      description: json['DESCRIPTION'],
      priceGem: json['PRICE_GEM'],
      priceExp: json['PRICE_EXP'],
      imageUrl: json['IMAGE_URL'],
      rarity: (json['RARITY'] as num).toDouble(),
      isActive: json['IS_ACTIVE'],
      expBooster: json['expBooster'] != null
          ? ExpBooster.fromJson(json['expBooster'])
          : null,
      gemExchange: json['gemExchange'] != null
          ? GemExchange.fromJson(json['gemExchange'])
          : null,
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
      itemId: json['ITEM_ID'] ?? 0, // Default to 0 if null
      boostMultiplier:
          (json['BOOST_MULTIPLIER'] as num?)?.toDouble() ?? 1.0, // Handle null
      boostDays: json['BOOST_DAYS'] ?? 0, // Default value
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
      itemId: json['ITEM_ID'],
      gemReward: json['GEM_REWARD'],
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
