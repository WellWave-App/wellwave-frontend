class Notifications {
  final int id;
  final String image;
  final String message;
  final String route;

  Notifications({
    required this.id,
    required this.image,
    required this.message,
    required this.route,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
      id: json['id'],
      image: json['image'],
      message: json['message'],
      route: json['route'],
    );
  }
}
