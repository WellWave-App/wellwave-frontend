class HabitSimpleModel {
  final String title;
  final String description;
  final int? expReward;
  final int? gemReward;
  final String thumbnailUrl;

  HabitSimpleModel({
    required this.title,
    required this.description,
    this.expReward,
    this.gemReward,
    required this.thumbnailUrl,
  });

  factory HabitSimpleModel.fromJson(Map<String, dynamic> json) {
    return HabitSimpleModel(
      title: json['TITLE'] as String,
      description: json['DESCRIPTION'] as String,
      expReward: json['EXP_REWARD'] as int ?? 0,
      gemReward: json['GEM_REWARD'] as int ?? 0,
      thumbnailUrl: json['THUMBNAIL_URL'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'TITLE': title,
      'DESCRIPTION': description,
      'EXP_REWARD': expReward,
      'GEM_REWARD': gemReward,
      'THUMBNAIL_URL': thumbnailUrl,
    };
  }
}

class RecommendHabitResponseModel {
  final List<HabitSimpleModel> habits;

  RecommendHabitResponseModel({
    required this.habits,
  });

  factory RecommendHabitResponseModel.fromJson(List<dynamic> json) {
    List<HabitSimpleModel> habitList = [];

    for (var item in json) {
      if (item is Map<String, dynamic> &&
          item.containsKey('habit') &&
          item['habit'] is Map<String, dynamic>) {
        var habitData = item['habit'] as Map<String, dynamic>;
        habitList.add(HabitSimpleModel.fromJson(habitData));
      }
    }

    return RecommendHabitResponseModel(habits: habitList);
  }

  Map<String, dynamic> toJson() {
    return {
      'habits': habits.map((habit) => habit.toJson()).toList(),
    };
  }
}
