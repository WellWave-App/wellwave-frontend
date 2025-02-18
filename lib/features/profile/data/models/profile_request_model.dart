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
  final int? stepPerWeek;
  final int? exercisePerWeek;
  final UserLeague? userLeague;
  final WeeklyGoal? weeklyGoal;

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
    this.weeklyGoal,
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
      exp: json['userInfo']['EXP'] as int,
      gem: json['userInfo']['GEM'] as int,
      stepPerWeek: json['userInfo']['USER_GOAL_STEP_WEEK'] ?? 0,
      exercisePerWeek: json['userInfo']['USER_GOAL_EX_TIME_WEEK'] ?? 0,
      userLeague: json['userLeague'] != null
          ? UserLeague.fromJson(json['userLeague'])
          : null,
      weeklyGoal: json['weeklyGoal'] != null
          ? WeeklyGoal.fromJson(json['weeklyGoal'])
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
      id: json['LB_ID'] as int,
      name: json['LEAGUE_NAME'] as String,
      minExp: json['MIN_EXP'] as int,
      maxExp: json['MAX_EXP'] as int,
    );
  }
}

class WeeklyGoal {
  final Progress progress;
  final int daysLeft;

  WeeklyGoal({required this.progress, required this.daysLeft});

  factory WeeklyGoal.fromJson(Map<String, dynamic> json) {
    return WeeklyGoal(
      progress: Progress.fromJson(json['progress']),
      daysLeft: json['daysLeft'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'progress': progress.toJson(),
      'daysLeft': daysLeft,
    };
  }
}

class Progress {
  final Goal step;
  final Goal exerciseTime;
  final Goal mission;

  Progress(
      {required this.step, required this.exerciseTime, required this.mission});

  factory Progress.fromJson(Map<String, dynamic> json) {
    return Progress(
      step: Goal.fromJson(json['step']),
      exerciseTime: Goal.fromJson(json['exercise_time']),
      mission: Goal.fromJson(json['mission']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'step': step.toJson(),
      'exercise_time': exerciseTime.toJson(),
      'mission': mission.toJson(),
    };
  }
}

class Goal {
  final int current;
  final int goal;

  Goal({required this.current, required this.goal});

  factory Goal.fromJson(Map<String, dynamic> json) {
    return Goal(
      current: json['current'],
      goal: json['goal'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current': current,
      'goal': goal,
    };
  }
}
