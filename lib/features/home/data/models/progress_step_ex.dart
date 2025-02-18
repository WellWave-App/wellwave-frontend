class ProgressStepEx {
  final int currentSteps;
  final int goalSteps;
  final int currentExercises;
  final int goalExercises;

  ProgressStepEx({
    required this.currentSteps,
    required this.goalSteps,
    required this.currentExercises,
    required this.goalExercises,
  });

  factory ProgressStepEx.fromJson(Map<String, dynamic> json) {
    return ProgressStepEx(
      currentSteps: json['currentSteps'] ?? 0,
      goalSteps: json['goalSteps'] ?? 0,
      currentExercises: json['currentExercises'] ?? 0,
      goalExercises: json['goalExercises'] ?? 0,
    );
  }
}
