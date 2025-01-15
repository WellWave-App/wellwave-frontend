import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../common/widget/app_bar.dart';
import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/app_images.dart';
import '../../../../config/constants/app_strings.dart';

class SetWeeklyGoalScreen extends StatefulWidget {
  const SetWeeklyGoalScreen({super.key});

  @override
  State<SetWeeklyGoalScreen> createState() => _SetWeeklyGoalScreenState();
}

class _SetWeeklyGoalScreenState extends State<SetWeeklyGoalScreen> {
  int stepPerWeek = 10000;
  int exercisePerWeek = 100;

  Widget _buildConfirmButton() {
    return Expanded(
      child: SizedBox(
        width: 170,
        height: 60,
        child: TextButton(
          onPressed: _submitLogs,
          style: ButtonStyle(
            backgroundColor:
                WidgetStateProperty.all<Color>(AppColors.primaryColor),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
          ),
          child: Text(AppStrings.confirmText,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.white)),
        ),
      ),
    );
  }

  Widget _buildCancleButton() {
    return Expanded(
      child: SizedBox(
        width: 170,
        height: 60,
        child: TextButton(
          onPressed: () => setState(() => Navigator.pop(context)),
          style: ButtonStyle(
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
                side: const BorderSide(color: AppColors.primaryColor, width: 1),
              ),
            ),
          ),
          child: Text(AppStrings.cancleText,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.primaryColor)),
        ),
      ),
    );
  }

  void _submitLogs() {
    // String formattedtimeStarttime = DateFormat('HH:mm').format(startTime);
    // String formattedtimeEndtime = DateFormat('HH:mm').format(endTime);
    // int intervalMinute = (double.parse(hourSet) * 60).toInt();

    // context.read<NotiBloc>().add(CreateDrinkRangeEvent(
    //       uid: AppStrings.uid,
    //       startTime: formattedtimeStarttime,
    //       endTime: formattedtimeEndtime,
    //       intervalMinute: intervalMinute,
    //     ));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: CustomAppBar(
            title: AppStrings.goalText, context: context, onLeading: true),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 36),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(AppImages.fireGoalIcon, height: 21),
                      const SizedBox(width: 8),
                      Text(
                        AppStrings.goalAmountText,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 27),
                    decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(AppStrings.stepPerWeekText,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith())
                              ],
                            ),
                            GestureDetector(
                              onTap: () async {
                                int? result = await showModalBottomSheet<int>(
                                    backgroundColor: AppColors.whiteColor,
                                    context: context,
                                    builder: (context) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 24, horizontal: 20),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                height: 3,
                                                width: 140,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                margin: const EdgeInsets.only(
                                                    bottom: 8),
                                              ),
                                              const SizedBox(height: 40),
                                              // Expanded(
                                              // child: CupertinoDatePicker(
                                              //   initialDateTime: startTime,
                                              //   mode: CupertinoDatePickerMode
                                              //       .time,
                                              //   use24hFormat: true,
                                              //   onDateTimeChanged:
                                              //       (DateTime newTime) {
                                              //     setState(() =>
                                              //         startTime = newTime);
                                              //   },
                                              // ),
                                              // ),
                                              const SizedBox(
                                                height: 24,
                                              ),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    _buildCancleButton(),
                                                    const SizedBox(width: 10),
                                                    _buildConfirmButton()
                                                  ])
                                            ],
                                          ),
                                        ));
                                // if (result != null) {
                                //   setState(() {
                                //     startTime = result as DateTime;
                                //   });
                                // }
                              },
                              child: Row(
                                children: [
                                  Text('$stepPerWeek ${AppStrings.stepText}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              color: AppColors
                                                  .secondaryDarkColor)),
                                  const SizedBox(width: 8),
                                  const Icon(
                                    Icons.navigate_next_rounded,
                                    color: AppColors.greyColor,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 38),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(AppStrings.exercisePerWeekText,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith())
                              ],
                            ),
                            GestureDetector(
                              onTap: () async {
                                int? result = await showModalBottomSheet<int>(
                                    backgroundColor: AppColors.whiteColor,
                                    context: context,
                                    builder: (context) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 24, horizontal: 20),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                height: 3,
                                                width: 140,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                margin: const EdgeInsets.only(
                                                    bottom: 8),
                                              ),
                                              const SizedBox(height: 40),
                                              // Expanded(
                                              // child: CupertinoDatePicker(
                                              //   initialDateTime: startTime,
                                              //   mode: CupertinoDatePickerMode
                                              //       .time,
                                              //   use24hFormat: true,
                                              //   onDateTimeChanged:
                                              //       (DateTime newTime) {
                                              //     setState(() =>
                                              //         startTime = newTime);
                                              //   },
                                              // ),
                                              // ),
                                              const SizedBox(
                                                height: 24,
                                              ),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    _buildCancleButton(),
                                                    const SizedBox(width: 10),
                                                    _buildConfirmButton()
                                                  ])
                                            ],
                                          ),
                                        ));
                                // if (result != null) {
                                //   setState(() {
                                //     startTime = result as DateTime;
                                //   });
                                // }
                              },
                              child: Row(
                                children: [
                                  Text(
                                      '$exercisePerWeek ${AppStrings.minuteText}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              color: AppColors
                                                  .secondaryDarkColor)),
                                  const SizedBox(width: 8),
                                  const Icon(
                                    Icons.navigate_next_rounded,
                                    color: AppColors.greyColor,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        // const SizedBox(height: 11)
                      ],
                    ),
                  ),
                ],
              )),
        ));
  }
}
