class AuthModel {
  final String email;
  final String password;

  AuthModel({
    required this.email,
    required this.password,
  });

  // Convert AuthModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'EMAIL': email,
      'PASSWORD': password,
    };
  }

  // Convert JSON to AuthModel
  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      email: json['EMAIL'],
      password: json['PASSWORD'],
    );
  }
}
