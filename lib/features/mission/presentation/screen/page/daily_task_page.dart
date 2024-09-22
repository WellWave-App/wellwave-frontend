import 'package:flutter/material.dart';
import 'package:wellwave_frontend/common/widget/app_bar.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';

class DailyTaskPage extends StatelessWidget {
  const DailyTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: CustomAppBar(
          context: context,
          title: AppStrings.dailyTaskText,
          backgroundColor: AppColors.backgroundColor,
          onLeading: true,
        ),
        body: Column(
          children: [
            TabBar(
              tabAlignment: TabAlignment.start,
              isScrollable: true,
              labelPadding: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.only(left: 10),
              dividerColor: Colors.transparent,
              labelColor: AppColors.blackColor,
              unselectedLabelColor: AppColors.tabTextGrayColor,
              indicatorColor: AppColors.blackColor,
              labelStyle: Theme.of(context).textTheme.titleSmall,
              tabs: const [
                Tab(text: AppStrings.guideText),
                Tab(text: AppStrings.eatingText),
                Tab(text: AppStrings.exerciseText),
                Tab(text: AppStrings.sleepText),
              ],
            ),
            // Wrap the Column in an Expanded widget
            const Expanded(
              child: TabBarView(
                children: [
                  Center(child: Text('แนะนำ')),
                  Center(child: Text('ภารกิจอาหาร')),
                  Center(child: Text('ภารกิจการออกกำลังกาย')),
                  Center(child: Text('ภารกิจอื่น')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
