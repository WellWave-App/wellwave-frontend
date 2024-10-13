import 'package:flutter/material.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/start_overview/presentation/widget/start_recommend.dart';

class StartOverviewScreen extends StatelessWidget {
  final List<String> titles = [
    AppStrings.metabolicSyndromeText,
    AppStrings.metaEffectText,
    AppStrings.metaBehaviorText,
  ];

  final List<String> descriptions = [
    AppStrings.metabolicDescriptionText,
    AppStrings.metaEffectDescriptionText,
    AppStrings.metaBehaviorDescriptionText,
  ];

  final List<String> imageUrls = [
    AppImages.metabolicSyndromeImage,
    AppImages.metaEffectImage,
    AppImages.metaBehaviorImage,
  ];

  StartOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StartRecommend(
        titles: titles,
        descriptions: descriptions,
        imageUrls: imageUrls,
      ),
    );
  }
}
