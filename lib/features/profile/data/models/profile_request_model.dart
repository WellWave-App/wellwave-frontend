class ProfileRequestModel {
  final int uid;
  final String imageUrl;
  final String username;
  final int yearOfBirth;
  final bool gender;
  final num height;
  final num weight;
  final int gem;
  final int exp;

  ProfileRequestModel({
    required this.uid,
    required this.imageUrl,
    required this.username,
    required this.yearOfBirth,
    required this.gender,
    required this.height,
    required this.weight,
    required this.exp,
    required this.gem,
  });

  ProfileRequestModel copyWith({
    String? imageUrl,
    String? username,
    int? yearOfBirth,
    bool? gender,
    double? height,
    double? weight,
    int? userGoal,
    String? email,
  }) {
    return ProfileRequestModel(
      imageUrl: imageUrl ?? this.imageUrl,
      username: username ?? this.username,
      yearOfBirth: yearOfBirth ?? this.yearOfBirth,
      gender: gender ?? this.gender,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      uid: uid,
      exp: exp,
      gem: gem,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'IMAGE_URL': imageUrl,
      'USERNAME': username,
      'YEAR_OF_BIRTH': yearOfBirth,
      'GENDER': gender,
      'HEIGHT': height,
      'WEIGHT': weight,
      'UID': uid,
      'EXP': exp,
      'GEM': gem,
    };
  }

  factory ProfileRequestModel.fromJson(Map<String, dynamic> json) {
    return ProfileRequestModel(
      uid: json['userInfo']['UID'] as int,
      imageUrl: json['userInfo']['IMAGE_URL'] as String? ?? "",
      username: json['userInfo']['USERNAME'] as String? ?? "",
      yearOfBirth: json['userInfo']['YEAR_OF_BIRTH'] as int? ?? 0,
      gender: json['userInfo']['GENDER'] as bool? ?? false,
      height: (json['userInfo']['HEIGHT'] as num?)?.toDouble() ?? 0.0,
      weight: (json['userInfo']['WEIGHT'] as num?)?.toDouble() ?? 0.0,
      exp: json['userInfo']['EXP'] as int,
      gem: json['userInfo']['GEM'] as int,
    );
  }

  Map<String, dynamic> toEditLogsRequestJson(String isShowToEmployee) {
    return {
      'IMAGE_URL': imageUrl,
      'USERNAME': username,
      'YEAR_OF_BIRTH': yearOfBirth,
      'GENDER': gender,
      'HEIGHT': height,
      'WEIGHT': weight,
      'UID': uid,
      'EXP': exp,
      'GEM': gem,
    };
  }
}
