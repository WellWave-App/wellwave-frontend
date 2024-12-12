class ProfileRequestModel {
  final int uid;
  final String imageUrl;
  final String username;
  final int yearOfBirth;
  final bool gender;
  final double height;
  final double weight;
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
      'UID' : uid,
      'EXP' : exp,
      'GEM' : gem,
    };
  }

  factory ProfileRequestModel.fromJson(
      Map<String, dynamic> json) {
    return ProfileRequestModel(
      uid: json['UID'] as int, 
      imageUrl: json['IMAGE_URL'] as String? ?? "",
      username: json['USERNAME'] as String? ?? "",
      yearOfBirth: json['YEAR_OF_BIRTH'] as int? ?? 0,
      gender: json['GENDER'] as bool? ?? false,
      height: (json['HEIGHT'] as num?)?.toDouble() ?? 0.0,
      weight: (json['WEIGHT'] as num?)?.toDouble() ?? 0.0,
      exp: json['EXP'] as int, 
      gem: json['GEM'] as int, 
      
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
      'UID' : uid,
      'EXP' : exp,
      'GEM' : gem,
    };
  }
}
