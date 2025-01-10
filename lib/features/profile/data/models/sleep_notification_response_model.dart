class SleepNotificationResponseModel {
  final String settingType;
  final bool isActive;
  final SettingDetail setting;

  SleepNotificationResponseModel({
    required this.settingType,
    required this.isActive,
    required this.setting,
  });

  factory SleepNotificationResponseModel.fromJson(Map<String, dynamic> json) {
    return SleepNotificationResponseModel(
      settingType: json['settingType'] ?? 'BEDTIME',
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
  final int uid;
  final String notificationType;
  final String bedtime;
  final String wakeTime;

  SettingDetail({
    required this.uid,
    required this.notificationType,
    required this.bedtime,
    required this.wakeTime,
  });

  factory SettingDetail.fromJson(Map<String, dynamic> json) {
    return SettingDetail(
      uid: json['UID'] as int,
      notificationType: json['NOTIFICATION_TYPE'] ?? 'BEDTIME',
      bedtime: json['BEDTIME'] ?? '',
      wakeTime: json['WAKE_TIME'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'UID': uid,
      'NOTIFICATION_TYPE': notificationType,
      'BEDTIME': bedtime,
      'WAKE_TIME': wakeTime,
    };
  }
}
