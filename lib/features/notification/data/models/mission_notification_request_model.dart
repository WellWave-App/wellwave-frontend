class MissionNotificationModel {
  final int hid;
  final String title;
  final bool isNotificationEnabled;
  final Map<String, bool> weekdaysNoti;

  MissionNotificationModel({
    required this.hid,
    required this.title,
    required this.isNotificationEnabled,
    required this.weekdaysNoti,
  });

  MissionNotificationModel copyWith({
    int? hid,
    String? title,
    bool? isNotificationEnabled,
    Map<String, bool>? weekdaysNoti,
  }) {
    return MissionNotificationModel(
      hid: hid ?? this.hid,
      title: title ?? this.title,
      isNotificationEnabled:
          isNotificationEnabled ?? this.isNotificationEnabled,
      weekdaysNoti: weekdaysNoti ?? this.weekdaysNoti,
    );
  }

  factory MissionNotificationModel.fromJson(Map<String, dynamic> json) {
    return MissionNotificationModel(
      isNotificationEnabled: json['IS_NOTIFICATION_ENABLED'] ?? false,
      title: json['habits']?['TITLE'] ?? '',
      weekdaysNoti: Map<String, bool>.from(json['WEEKDAYS_NOTI'] ?? {}),
      hid: json['habits']?['HID'] ?? 0, // Updated to get HID from habits object
    );
  }
}
