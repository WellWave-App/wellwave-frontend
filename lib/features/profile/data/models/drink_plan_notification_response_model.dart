class DrinkPlanNotificationResponseModel {
  final String? settingType;
  final bool isActive;
  final SettingDetail setting;

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
      setting: SettingDetail.fromJson(json['setting']),
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

class SettingDetail {
  final int? uid;
  final String? notificationType;
  final String notitime;
  final int glassNumber;

  SettingDetail({
    this.uid,
    this.notificationType,
    required this.notitime,
    required this.glassNumber,
  });

  factory SettingDetail.fromJson(Map<String, dynamic> json) {
    return SettingDetail(
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
