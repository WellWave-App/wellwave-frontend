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
  final int? stepPerWeek;
  final int? exercisePerWeek;

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
    this.stepPerWeek,
    this.exercisePerWeek,
  });

  ProfileRequestModel copyWith(
      {String? imageUrl,
      String? username,
      int? yearOfBirth,
      bool? gender,
      double? height,
      double? weight,
      int? userGoal,
      String? email,
      int? stepPerWeek,
      int? exercisePerWeek}) {
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
        stepPerWeek: stepPerWeek,
        exercisePerWeek: exercisePerWeek);
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
      'USER_GOAL_STEP_WEEK': stepPerWeek,
      'USER_GOAL_EX_TIME_WEEK': exercisePerWeek
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
      exp: json['userInfo']['EXP'] as int? ?? 0,
      gem: json['userInfo']['GEM'] as int? ?? 0,
      stepPerWeek: json['userInfo']['USER_GOAL_STEP_WEEK'] as int? ?? 0,
      exercisePerWeek: json['userInfo']['USER_GOAL_EX_TIME_WEEK'] as int? ?? 0,
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
      'USER_GOAL_STEP_WEEK': stepPerWeek,
      'USER_GOAL_EX_TIME_WEEK': exercisePerWeek
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
      id: json['UID'] as int? ?? 0,
      name: json['CURRENT_LEAGUE'] as String? ?? "Unknown",
      minExp: json['CURRENT_EXP'] as int? ?? 0,
      maxExp: json['PREVIOUS_RANK'] as int? ?? 0,
    );
  }
}

class UsersAchievement {
  final String? imgPath;
  final String? achTitle;
  final DateTime? dateAcheived;

  UsersAchievement({
    this.imgPath,
    this.achTitle,
    this.dateAcheived,
  });

  factory UsersAchievement.fromJson(Map<String, dynamic> json) {
    return UsersAchievement(
      imgPath: json['imgPath'] as String,
      achTitle: json['achTitle'] as String,
      dateAcheived: json['dateAcheived'] as DateTime,
    );
  }
}
