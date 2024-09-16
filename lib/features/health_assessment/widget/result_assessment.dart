import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wellwave_frontend/common/widget/app_bar.dart';
import 'package:wellwave_frontend/common/widget/custom_button.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_pages.dart';
import 'package:wellwave_frontend/features/health_assessment/widget/details_health_card%20notused.dart';
import 'package:wellwave_frontend/features/health_assessment/widget/risk_arc.dart';
import 'package:wellwave_frontend/features/health_assessment/widget/risk_card.dart';

class ResultAssessment extends StatelessWidget {
  const ResultAssessment({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        onLeading: false,
        title: 'สรุปผลการประเมิน',
        textColor: Colors.black,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            GaugeWidget(),
            const SizedBox(
              height: 48,
            ),
            const RiskCard(
              title: 'โรคเบาหวาน',
              riskText: 'เสี่ยงสูง',
              progress: 0.85,
            ),
            const SizedBox(
              height: 24,
            ),
            const RiskCard(
              title: 'โรคความดันโลหิตสูง',
              riskText: 'ไม่มีความเสี่ยง',
              progress: 0.25,
            ),
            const SizedBox(
              height: 24,
            ),
            const RiskCard(
              title: 'โรคอ้วน',
              riskText: 'เสี่ยงสูงมาก',
              progress: 1,
            ),
            const SizedBox(
              height: 24,
            ),
            const RiskCard(
              title: 'โรคไขมันในเลือดสูง',
              riskText: 'เสี่ยงขั้นต้น',
              progress: 0.4,
            ),
            const SizedBox(height: 48),
            Positioned(
              bottom: screenHeight * 0.20,
              child: Center(
                child: CustomButton(
                  bgColor: AppColors.primaryColor,
                  textColor: AppColors.backgroundColor,
                  width: 250,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => _buildRecommend(context),
                      ),
                    );
                  },
                  title: 'ถัดไป',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommend(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Stack(
          children: [
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppImages.recommendPlanIcon),
                  const SizedBox(height: 64),
                  Text(
                    "คำแนะนำสำหรับคุณ",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: AppColors.blackColor),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "ลดอาหารประเภทแป้ง และอาหารไขมันสูง ออกกำลังกายอย่างสม่ำเสมอ อย่างน้อย 3 ครั้งต่อสัปดาห์ ครั้งละ 30-60 นาที",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: AppColors.blackColor),
                  ),
                  const SizedBox(height: 72),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomButton(
                      width: 250,
                      bgColor: AppColors.primaryColor,
                      textColor: AppColors.backgroundColor,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  _buildHealthConnect(context)),
                        );
                      },
                      title: 'ถัดไป',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHealthConnect(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Stack(
          children: [
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppImages.healthconnectIcon),
                  const SizedBox(height: 64),
                  Text(
                    "ต้องการเชื่อมต่อข้อมูลสุขภาพหรือไม่?",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: AppColors.blackColor),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "เชื่อมต่อกับ Google Fit เพื่อให้การติดตามสุขภาพของคุณแม่นยำยิ่งขึ้น",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: AppColors.blackColor),
                  ),
                  const SizedBox(height: 72),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomButton(
                      width: 250,
                      bgColor: AppColors.primaryColor,
                      textColor: AppColors.backgroundColor,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  _buildFinishGoalWeight(context)),
                        );
                      },
                      title: 'เชื่อมต่อทันที',
                    ),
                    const SizedBox(height: 12),
                    CustomButton(
                      bgColor: Colors.transparent,
                      textColor: AppColors.darkgrayColor,
                      width: 250,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  _buildFinishGoalWeight(context)),
                        );
                      },
                      title: 'ไว้ภายหลัง',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFinishGoalWeight(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      context.goNamed(AppPages.homeName);
    });

    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  children: [
                    SvgPicture.asset(AppImages.recommendIcon),
                    const SizedBox(height: 48),
                    Text(
                      "ยินดีด้วย!",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: AppColors.blackColor),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "แผนสุขภาพส่วนตัวของคุณพร้อมแล้ว \nเริ่มต้นการดูแลสุขภาพที่ดีที่สุดสำหรับคุณได้เลย",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: AppColors.blackColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
