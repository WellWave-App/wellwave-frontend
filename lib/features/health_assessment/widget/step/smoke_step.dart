import 'package:flutter/material.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/features/health_assessment/widget/rectangle_box.dart';

class SmokeStep extends StatelessWidget {
  const SmokeStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "คุณสูบบุหรี่หรือไม่?",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 48,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RectangleBox(
                icon: AppImages.smokeUsuallyIcon,
                title: "สูบเป็นประจำ",
                isMultiSelect: false,
              ),
              RectangleBox(
                icon: AppImages.smokeUedtoIcon,
                title: "เลิกสูบแล้ว",
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
                icon: AppImages.smokeNeverIcon,
                title: "ไม่สูบ",
                isMultiSelect: false,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
