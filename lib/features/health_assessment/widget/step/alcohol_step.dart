import 'package:flutter/material.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/features/health_assessment/widget/rectangle_box.dart';

class AlcoholStep extends StatelessWidget {
  const AlcoholStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "คุณดื่มเครื่องดื่มแอลกอฮอล์หรือไม่?",
            style: Theme.of(context).textTheme.titleLarge,
          ),
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
    );
  }
}
