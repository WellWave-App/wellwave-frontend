import 'package:wellwave_frontend/features/home/data/models/progress_step_ex.dart';

final List<Map<String, dynamic>> progressStepExCardMockData = [
  {
    "currentSteps": 1500,
    "goalSteps": 3000,
    "currentExercises": 150,
    "goalExercises": 150,
  },
];

List<ProgressStepEx> getMockProgressStepExCardData() {
  return progressStepExCardMockData
      .map((data) => ProgressStepEx.fromJson(data))
      .toList();
}
