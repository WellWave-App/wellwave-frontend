class MissionNotificationModel {
  final bool isNotificationEnabled;
  final String title;
  final Map<String, bool> weekdaysNoti;
  final int total;

  MissionNotificationModel({
    required this.isNotificationEnabled,
    required this.title,
    required this.weekdaysNoti,
    required this.total,
  });

  factory MissionNotificationModel.fromJson(Map<String, dynamic> json) {
    return MissionNotificationModel(
      isNotificationEnabled: json['IS_NOTIFICATION_ENABLED'] ?? false,
      title: json['habits']?['TITLE'] ?? '',
      weekdaysNoti: Map<String, bool>.from(json['WEEKDAYS_NOTI'] ?? {}),
      total: json['meta']?['total'] ?? 0,
    );
  }
}
