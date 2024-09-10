import 'package:flutter/material.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/features/health_assessment/widget/rectangle_box.dart';

class AlcoholStep extends StatelessWidget {
  const AlcoholStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 24),
        child: Column(
          children: [
            Text(
              "การดื่มเครื่องดื่มแอลกอฮอล์",
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
                  icon: AppImages.alcoholUsuallyIcon,
                  title: "ดื่มเป็นประจำ",
                  subtitle: "(เกิน 5 ครั้ง / สัปดาห์)",
                  isMultiSelect: false,
                ),
                RectangleBox(
                  icon: AppImages.alcoholSometimesIcon,
                  title: "ดื่มเป็นครั้งคราว",
                  subtitle: "(ไม่เกิน 5 ครั้ง / สัปดาห์)",
                  isMultiSelect: false,
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
                  icon: AppImages.alcoholUsedtoIcon,
                  title: "เคยดื่มแต่เลิกแล้ว",
                  isMultiSelect: false,
                ),
                RectangleBox(
                  icon: AppImages.alcoholNeverIcon,
                  title: "ไม่ดื่มแอลกอฮอล์",
                  isMultiSelect: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
