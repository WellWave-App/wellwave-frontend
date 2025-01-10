class DrinkPlanNotificationResponseModel {
  final String? settingType;
  final bool isActive;
  final DrinkSettingDetail setting;

  DrinkPlanNotificationResponseModel({
    this.settingType,
    required this.isActive,
    required this.setting,
  });

  factory DrinkPlanNotificationResponseModel.fromJson(
      Map<String, dynamic> json) {
    return DrinkPlanNotificationResponseModel(
      settingType: json['settingType'] ?? 'WATER_PLAN',
      isActive: json['isActive'] as bool,
      setting: DrinkSettingDetail.fromJson(json['setting']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'settingType': settingType,
      'isActive': isActive,
      'setting': setting.toJson(),
    };
  }
}

class DrinkSettingDetail {
  final int? uid;
  final String? notificationType;
  final String notitime;
  final int glassNumber;

  DrinkSettingDetail({
    this.uid,
    this.notificationType,
    required this.notitime,
    required this.glassNumber,
  });

  factory DrinkSettingDetail.fromJson(Map<String, dynamic> json) {
    return DrinkSettingDetail(
      uid: json['UID'] as int,
      notificationType: json['NOTIFICATION_TYPE'] ?? 'WATER_PLAN',
      notitime: json['NOTI_TIME'] ?? '',
      glassNumber: json['GLASS_NUMBER'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'UID': uid,
      'NOTIFICATION_TYPE': notificationType,
      'NOTI_TIME': notitime,
      'GLASS_NUMBER': glassNumber,
    };
  }
}
