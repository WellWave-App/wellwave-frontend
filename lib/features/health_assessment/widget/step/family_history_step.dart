import 'package:flutter/material.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/features/health_assessment/widget/rectangle_box.dart';

class FamilyHistoryStep extends StatelessWidget {
  const FamilyHistoryStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 24),
        child: Column(
          children: [
            Text(
              "ประวัติเจ็บป่วยในครอบครัว",
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 8,
            ),
            Text("บอกข้อมูลของคุณให้เราทราบเพื่อผลลัพธ์ที่แม่นยำ",
                style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(
              height: 48,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RectangleBox(
                  icon: AppImages.famhistoryHyperIcon,
                  title: "โรคความดัน\nโลหิตสูง",
                  isMultiSelect: true,
                ),
                RectangleBox(
                  icon: AppImages.famhistoryVascularIcon,
                  title: "โรคไขมันใน\nหลอดเลือดผิดปกติ",
                  isMultiSelect: true,
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RectangleBox(
                  icon: AppImages.famhistoryDiabetesIcon,
                  title: "โรคเบาหวาน",
                  isMultiSelect: true,
                ),
                RectangleBox(
                  icon: AppImages.famhistoryParalysisIcon,
                  title: "โรคอัมพาต",
                  isMultiSelect: true,
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RectangleBox(
                  icon: AppImages.famhistoryArteryIcon,
                  title: "โรคหลอดเลือด\nหัวใจ",
                  isMultiSelect: true,
                ),
                RectangleBox(
                  icon: AppImages.famhistoryConfusedIcon,
                  title: "ไม่ทราบ / \nไม่มีประวัติเจ็บป่วย",
                  isMultiSelect: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
