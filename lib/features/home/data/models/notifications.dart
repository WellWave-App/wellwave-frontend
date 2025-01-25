class Notifications {
  final int id;
  final String image;
  final String message;
  final String route;
  bool isRead;

  Notifications({
    required this.id,
    required this.image,
    required this.message,
    required this.route,
    required this.isRead,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
      id: json['id'],
      image: json['image'],
      message: json['message'],
      route: json['route'],
      isRead: json['isRead'] ?? false,
    );
  }

  void markAsRead() {
    isRead = true;
  }
}
