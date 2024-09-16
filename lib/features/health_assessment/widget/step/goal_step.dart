import 'package:flutter/material.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/features/health_assessment/widget/goal_box.dart';

class GoalStep extends StatelessWidget {
  const GoalStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "สุดท้ายแล้ว! บอกเป้าหมายของคุณให้เรารู้หน่อยได้ไหม?",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 48,
            ),
            const GoalBox(
              icon: AppImages.goalMuscleIcon,
              title: "สร้างกล้ามเนื้อ",
              isMultiSelect: false,
            ),
            const SizedBox(
              height: 24,
            ),
            const GoalBox(
              icon: AppImages.goalLoseweightIcon,
              title: "ลดน้ำหนัก",
              isMultiSelect: false,
            ),
            const SizedBox(
              height: 24,
            ),
            const GoalBox(
              icon: AppImages.goalHealthyIcon,
              title: "สุขภาพดี",
              isMultiSelect: false,
            ),
          ],
        ),
      ),
    );
  }
}
