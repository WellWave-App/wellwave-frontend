class HabitRequestModel {
  final List<HabitItemRequestModel> habits;
  final HabitMetaRequestModel meta;

  const HabitRequestModel({
    required this.habits,
    required this.meta,
  });

  factory HabitRequestModel.fromJson(Map<String, dynamic> json) {
    return HabitRequestModel(
      habits: (json['data'] as List)
          .map((e) => HabitItemRequestModel.fromJson(e))
          .toList(),
      meta: HabitMetaRequestModel.fromJson(json['meta']),
    );
  }
}

class HabitItemRequestModel {
  final int hid;
  final String title;
  final String description;
  final String advice;
  final String category;
  final String? exerciseType;
  final String trackingType;
  final int expReward;
  final int? gemReward;
  final int? defaultDailyMinuteGoal;
  final int defaultDaysGoal;
  final String thumbnailUrl;
  final bool isDaily;
  final HabitConditionsRequestModel conditions;
  final bool isActive;
  final HabitChallengeInfoRequestModel? challengeInfo;
  final dynamic scoreInfo;

  const HabitItemRequestModel({
    required this.hid,
    required this.title,
    required this.description,
    required this.advice,
    required this.category,
    this.exerciseType,
    required this.trackingType,
    required this.expReward,
    this.gemReward,
    this.defaultDailyMinuteGoal,
    required this.defaultDaysGoal,
    required this.thumbnailUrl,
    required this.isDaily,
    required this.conditions,
    required this.isActive,
    this.challengeInfo,
    this.scoreInfo,
  });

  factory HabitItemRequestModel.fromJson(Map<String, dynamic> json) {
    return HabitItemRequestModel(
      hid: json['HID'] ?? 0,
      title: json['TITLE'] ?? '',
      description: json['DESCRIPTION'] ?? '',
      advice: json['ADVICE'] ?? '',
      category: json['CATEGORY'] ?? '',
      exerciseType: json['EXERCISE_TYPE'],
      trackingType: json['TRACKING_TYPE'] ?? '',
      expReward: json['EXP_REWARD'] ?? 0,
      gemReward: json['GEM_REWARD'],
      defaultDailyMinuteGoal: json['DEFAULT_DAILY_MINUTE_GOAL'],
      defaultDaysGoal: json['DEFAULT_DAYS_GOAL'] ?? 0,
      thumbnailUrl: json['THUMBNAIL_URL'] ?? '',
      isDaily: json['IS_DAILY'] ?? false,
      conditions:
          HabitConditionsRequestModel.fromJson(json['CONDITIONS'] ?? {}),
      isActive: json['isActive'] ?? false,
      challengeInfo: json['challengeInfo'] != null
          ? HabitChallengeInfoRequestModel.fromJson(json['challengeInfo'])
          : null,
      scoreInfo: json['scoreInfo'],
    );
  }
}

class HabitConditionsRequestModel {
  final bool obesityCondition;
  final bool diabetesCondition;
  final bool dyslipidemiaCondition;
  final bool hypertensionCondition;

  const HabitConditionsRequestModel({
    required this.obesityCondition,
    required this.diabetesCondition,
    required this.dyslipidemiaCondition,
    required this.hypertensionCondition,
  });

  factory HabitConditionsRequestModel.fromJson(Map<String, dynamic> json) {
    return HabitConditionsRequestModel(
      obesityCondition: json['OBESITY_CONDITION'] ?? false,
      diabetesCondition: json['DIABETES_CONDITION'] ?? false,
      dyslipidemiaCondition: json['DYSLIPIDEMIA_CONDITION'] ?? false,
      hypertensionCondition: json['HYPERTENSION_CONDITION'] ?? false,
    );
  }
}

class HabitChallengeInfoRequestModel {
  final int challengeId;
  final String startDate;
  final String endDate;
  final int streakCount;
  final int daysCompleted;
  final int totalDays;
  final int percentageProgress;

  const HabitChallengeInfoRequestModel({
    required this.challengeId,
    required this.startDate,
    required this.endDate,
    required this.streakCount,
    required this.daysCompleted,
    required this.totalDays,
    required this.percentageProgress,
  });

  factory HabitChallengeInfoRequestModel.fromJson(Map<String, dynamic> json) {
    return HabitChallengeInfoRequestModel(
      challengeId: json['challengeId'] ?? 0,
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      streakCount: json['streakCount'] ?? 0,
      daysCompleted: json['daysCompleted'] ?? 0,
      totalDays: json['totalDays'] ?? 0,
      percentageProgress: json['percentageProgress'] ?? 0,
    );
  }
}

class HabitMetaRequestModel {
  final int total;

  const HabitMetaRequestModel({
    required this.total,
  });

  factory HabitMetaRequestModel.fromJson(Map<String, dynamic> json) {
    return HabitMetaRequestModel(
      total: json['total'] ?? 0,
    );
  }
}
