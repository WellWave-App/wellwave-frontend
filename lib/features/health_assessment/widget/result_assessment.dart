import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wellwave_frontend/common/widget/app_bar.dart';
import 'package:wellwave_frontend/common/widget/custom_button.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_pages.dart';
import 'package:wellwave_frontend/features/health_assessment/widget/details_health_card.dart';
import 'package:wellwave_frontend/features/health_assessment/widget/risk_card.dart';

class ResultAssessment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 48,
            ),
            Text(
              "ผลการประเมิน",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 32,
            ),
            RiskCard(
              title: 'โรคเบาหวาน',
              riskText: 'คุณมีความเสี่ยงโรคเบาหวานสูง',
              progress: 0.85,
            ),
            const SizedBox(
              height: 24,
            ),
            RiskCard(
              title: 'โรคความดันโลหิตสูง',
              riskText: 'คุณไม่มีความเสี่ยงโรคความดันโลหิตสูง',
              progress: 0.25,
            ),
            const SizedBox(
              height: 24,
            ),
            RiskCard(
              title: 'โรคอ้วน',
              riskText: 'คุณมีความเสี่ยงโรคอ้วนสูง',
              progress: 1,
            ),
            const SizedBox(
              height: 24,
            ),
            RiskCard(
              title: 'โรคไขมันในเลือดสูง',
              riskText: 'คุณมีความเสี่ยงโรคไขมันในเลือดสูงขั้นต้น',
              progress: 0.4,
            ),
            SizedBox(height: 48),
            Positioned(
              bottom: screenHeight * 0.20,
              child: Center(
                child: CustomButton(
                  width: 250,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => _buildResultOverall(context)),
                    );
                  },
                  title: 'เสร็จสิ้น',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultOverall(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        onLeading: false,
        title: 'สรุปผลการประเมิน',
        textColor: Colors.black,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 180),
                SizedBox(height: 36),
                DetailsHealthCard(
                  title: 'ค่าน้ำตาลในเลือด',
                  value: '150 dg/L',
                ),
                SizedBox(height: 24),
                DetailsHealthCard(
                  title: 'Cholesterol',
                  value: '250 dg/L',
                ),
                SizedBox(height: 24),
                DetailsHealthCard(
                  title: 'Triglyceride',
                  value: '210 dg/L',
                ),
                SizedBox(height: 48),
                Text(
                  "คำแนะนำสำหรับคุณ",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: AppColors.darkblueColor),
                ),
                SizedBox(height: 16),
                Text(
                  "• ลดอาหารประเภทแป้ง และอาหารไขมันสูง \n• ออกกำลังกายอย่างสม่ำเสมอ โดยเน้นการคาร์ดิโอ ร่วมกับออกกำลังกายแบบเสริมสร้างกล้ามเนื้อด้วย โดยทำให้ได้อย่างน้อย 3 ครั้งต่อสัปดาห์ ครั้งละ 30-60 นาที ",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppColors.darkblueColor),
                ),
                SizedBox(height: 48),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding:
                  const EdgeInsets.only(bottom: 20), // 20 units from bottom
              child: CustomButton(
                width: 250,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => _buildGoalWeight(context)),
                  );
                },
                title: 'กำหนดเป้าหมาย',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalWeight(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 108),
                  Text(
                    "กำหนดเป้าหมายน้ำหนักของคุณ",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: AppColors.blackColor),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "บอกให้เราทราบ เพื่อปรับแผนที่เหมาะสมกับคุณมากยิ่งขึ้น",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: AppColors.blackColor),
                  ),
                  SizedBox(height: 540),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding:
                  const EdgeInsets.only(bottom: 20), // Adjust padding if needed
              child: CustomButton(
                width: 250,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => _buildFinishGoalWeight(context)),
                  );
                },
                title: 'เสร็จสิ้น',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFinishGoalWeight(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  children: [
                    SvgPicture.asset(AppImages.checkmarkGradientIcon),
                    SizedBox(height: 48),
                    Text(
                      "กำหนดเป้าหมายสำเร็จ",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: AppColors.blackColor),
                    ),
                    SizedBox(height: 12),
                    Text(
                      "แผนสุขภาพของคุณพร้อมแล้ว!",
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: AppColors.blackColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: CustomButton(
                width: 250,
                onPressed: () {
                  context.goNamed(AppPages.homeName);
                },
                title: 'เข้าสู่หน้าหลัก',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
