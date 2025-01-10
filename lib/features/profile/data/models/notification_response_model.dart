class NotificationResponseModel {
  final String settingType;
  final bool isActive;
  final SettingDetail setting;

  NotificationResponseModel({
    required this.settingType,
    required this.isActive,
    required this.setting,
  });

  factory NotificationResponseModel.fromJson(Map<String, dynamic> json) {
    return NotificationResponseModel(
      settingType: json['settingType'],
      isActive: json['isActive'],
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
  final int uid;
  final String notificationType;
  final String bedtime;

  SettingDetail({
    required this.uid,
    required this.notificationType,
    required this.bedtime,
  });

  factory SettingDetail.fromJson(Map<String, dynamic> json) {
    return SettingDetail(
      uid: json['UID'],
      notificationType: json['NOTIFICATION_TYPE'],
      bedtime: json['BEDTIME'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'UID': uid,
      'NOTIFICATION_TYPE': notificationType,
      'BEDTIME': bedtime,
    };
  }
}
