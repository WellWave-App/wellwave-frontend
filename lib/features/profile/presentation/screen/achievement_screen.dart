import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/profile/presentation/widget/acievement/achievement_record_card.dart';

import '../../../../common/widget/app_bar.dart';
import '../../../../config/constants/app_colors.dart';

class AchievementScreen extends StatelessWidget {
  const AchievementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(
        title: AppStrings.archeivementText,
        context: context,
        onLeading: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 36, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //  Record Section
              Text(
                AppStrings.yourRecordText,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 169, // Constrain the height of the horizontal scroll
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    ArchievementRecordCard(
                      svgPath: AppImages.medalSvg,
                      archievementName: 'ยอดนักแข่ง EXP',
                    ),
                    ArchievementRecordCard(
                      svgPath: AppImages.medalSvg,
                      archievementName: 'ยอดนักแข่ง EXP',
                    ),
                    ArchievementRecordCard(
                      svgPath: AppImages.medalSvg,
                      archievementName: 'ยอดนักแข่ง EXP',
                    ),
                    ArchievementRecordCard(
                      svgPath: AppImages.medalSvg,
                      archievementName: 'ยอดนักแข่ง EXP',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Medals Section
              Text(
                AppStrings.medalText,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              Column(
                children: [
                  Padding(
                    padding:  const EdgeInsets.symmetric(horizontal: 22.5),
                    child: Wrap(
                      spacing: 45.0, // Horizontal spacing between items
                      runSpacing: 16.0, // Vertical spacing between rows
                      alignment: WrapAlignment.start,
                      children: [
                        SvgPicture.asset(
                          AppImages.medalSvg,
                          height: 128,
                        ),
                        SvgPicture.asset(
                          AppImages.medalSvg,
                          height: 128,
                        ),
                        SvgPicture.asset(
                          AppImages.medalSvg,
                          height: 128,
                        ),
                        SvgPicture.asset(
                          AppImages.medalSvg,
                          height: 128,
                        ),
                        SvgPicture.asset(
                          AppImages.medalSvg,
                          height: 128,
                        ),
                        SvgPicture.asset(
                          AppImages.medalSvg,
                          height: 128,
                        ),
                        SvgPicture.asset(
                          AppImages.medalSvg,
                          height: 128,
                        ),
                        SvgPicture.asset(
                          AppImages.medalSvg,
                          height: 128,
                        ),
                        SvgPicture.asset(
                          AppImages.medalSvg,
                          height: 128,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
