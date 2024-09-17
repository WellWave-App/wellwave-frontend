import 'package:flutter/material.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/features/health_assessment/widget/rectangle_box.dart';

class FamilyHistoryStep extends StatelessWidget {
  const FamilyHistoryStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "คนในครอบครัวมีประวัติการเจ็บป่วยเหล่านี้ไหม?",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 48,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RectangleBox(
                icon: AppImages.famhistoryHyperIcon,
                title: "โรคความดันโลหิตสูง",
                isMultiSelect: true,
              ),
              RectangleBox(
                icon: AppImages.famhistoryVascularIcon,
                title: "โรคไขมันในหลอดเลือดผิดปกติ",
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
                title: "โรคหลอดเลือดหัวใจ",
                isMultiSelect: true,
              ),
              RectangleBox(
                icon: AppImages.famhistoryConfusedIcon,
                title: "ไม่ทราบ / ไม่มีประวัติเจ็บป่วย",
                isMultiSelect: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
