class Progress {
  final int id;
  final String rewardType;
  final int rewards;
  final double progress;
  final String taskDescription;

  Progress({
    required this.id,
    required this.rewardType,
    required this.rewards,
    required this.progress,
    required this.taskDescription,
  });

  factory Progress.fromJson(Map<String, dynamic> json) {
    return Progress(
      id: json['id'],
      rewardType: json['typeRewards'],
      rewards: json['rewards'],
      progress: json['progress'],
      taskDescription: json['taskDescription'],
    );
  }
}
