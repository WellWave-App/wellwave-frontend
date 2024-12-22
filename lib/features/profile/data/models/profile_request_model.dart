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
  final UserLeague? userLeague;

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
    this.userLeague,
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
      userLeague: json['userLeague'] != null
          ? UserLeague.fromJson(json['userLeague'])
          : null,
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

class UserLeague {
  final int id;
  final String name;
  final int minExp;
  final int maxExp;

  UserLeague({
    required this.id,
    required this.name,
    required this.minExp,
    required this.maxExp,
  });

  factory UserLeague.fromJson(Map<String, dynamic> json) {
    return UserLeague(
      id: json['LB_ID'] as int,
      name: json['LEAGUE_NAME'] as String,
      minExp: json['MIN_EXP'] as int,
      maxExp: json['MAX_EXP'] as int,
    );
  }
}
