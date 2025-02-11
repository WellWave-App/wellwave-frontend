class LoginStreakDataResponseModel {
  final int? uid;
  final DateTime? streakStartDate;
  final DateTime? lastLoginDate;
  final int? currentStreak;
  final int? longestStreak;
  final DateTime? lastUpdated;

  LoginStreakDataResponseModel({
    this.uid,
    this.streakStartDate,
    this.lastLoginDate,
    this.currentStreak,
    this.longestStreak,
    this.lastUpdated,
  });

  LoginStreakDataResponseModel copyWith({
    int? uid,
    DateTime? streakStartDate,
    DateTime? lastLoginDate,
    int? currentStreak,
    int? longestStreak,
    DateTime? lastUpdated,
  }) {
    return LoginStreakDataResponseModel(
      uid: uid ?? this.uid,
      streakStartDate: streakStartDate ?? this.streakStartDate,
      lastLoginDate: lastLoginDate ?? this.lastLoginDate,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'UID': uid,
      'STREAK_START_DATE': streakStartDate,
      'LAST_LOGIN_DATE': lastLoginDate,
      'CURRENT_STREAK': currentStreak,
      'LONGEST_STREAK': longestStreak,
      'LAST_UPDATED': lastUpdated,
    };
  }

  factory LoginStreakDataResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginStreakDataResponseModel(
      uid: json['uid'],
      streakStartDate: DateTime.tryParse(json['streakStartDate'] ?? '') ??
          DateTime(1970, 1, 1),
      lastLoginDate: DateTime.tryParse(json['lastLoginDate'] ?? '') ??
          DateTime(1970, 1, 1),
      currentStreak: json['currentStreak'] as int? ?? 0,
      longestStreak: json['longestStreak'] as int? ?? 0,
      lastUpdated:
          DateTime.tryParse(json['lastUpdated'] ?? '') ?? DateTime(1970, 1, 1),
    );
  }
}
