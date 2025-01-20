import 'package:wellwave_frontend/features/home/data/models/progress.dart';

final List<Map<String, dynamic>> progressMockData = [
  {
    "id": 1,
    "progress": 0.5,
    "taskDescription": "ทานโปรตีนจากเนื้อสัตว์สำหรับมื้อเช้า",
    "typeRewards": "EXP",
    "rewards": 15,
  },
  {
    "id": 2,
    "image": " AppImages.fireIcon",
    "progress": 0.7,
    "taskDescription": "Description of progress 2",
    "typeRewards": "EXP",
    "rewards": 15,
  },
  {
    "id": 3,
    "image": " AppImages.fireIcon",
    "progress": 0.7,
    "taskDescription":
        "Description of progressDescription of progress Description of progress ",
    "typeRewards": "EXP",
    "rewards": 15,
  },
];

List<Progress> getMockProgressData() {
  return progressMockData.map((data) => Progress.fromJson(data)).toList();
}
