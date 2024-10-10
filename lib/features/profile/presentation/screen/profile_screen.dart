import 'package:flutter/material.dart';
import 'package:wellwave_frontend/common/widget/app_bar.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/profile/presentation/widget/check_in_card.dart';
import 'package:wellwave_frontend/features/profile/presentation/widget/user_info.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String userID = '503450293';
    String userName = AppStrings.userNameText;
    int league = 0;
    int gemAmount = 20;
    int expAmount = 34;
    int currentDay = 4;

    return Scaffold(
        appBar: CustomAppBar(title: '', context: context, onLeading: true),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              UserInformation(
                userID: userID,
                userName: userName,
                leagueIndex: league,
                gemAmount: gemAmount,
                expAmount: expAmount,
              ),
              CheckInWidget(currentDay: currentDay),
              // const WeeklyLogsCard(
              //   title: AppStrings.stepWalkText,
              //   value: '4500',
              //   unit: AppStrings.stepText,
              //   chart: LineChartSample2(), 
              // ),
            ],
          ),
        )));
  }
}
