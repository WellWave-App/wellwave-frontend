import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';

import '../../../../common/widget/app_bar.dart';
import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/app_pages.dart';
import '../widget/noti_mission_widget.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  final List<bool> _isSwitched = [false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(
          title: AppStrings.alertText, context: context, onLeading: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 36),
          child: Column(
            children: [
              // Mission section
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(AppImages.fireIcon, height: 21),
                          const SizedBox(width: 8),
                          Text(
                            AppStrings.taskText,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 28,
                        child: TextButton(
                          onPressed: () {
                            context.goNamed(AppPages.logHistoryName);
                          },
                          style: OutlinedButton.styleFrom(
                            side:
                                const BorderSide(color: AppColors.primaryColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                          ),
                          child: Text(AppStrings.selectAllText,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: AppColors.secondaryDarkColor)),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Column(
                    children: [
                      NotiMissionWidget(
                        time: '01:05',
                        day: 'Everyday',
                        description: 'ชวนปั่น 100 km ใน 1 เดือน',
                      ),
                      NotiMissionWidget(
                        time: '01:05',
                        day: 'Everyday',
                        description: 'ชวนปั่น 100 km ใน 1 เดือน',
                      ),
                      NotiMissionWidget(
                        time: '01:05',
                        day: 'Everyday',
                        description: 'ชวนปั่น 100 km ใน 1 เดือน',
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 24),
              // Water section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(AppImages.waterIcon, height: 21),
                      const SizedBox(width: 8),
                      Text(
                        AppStrings.drinkingText,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 16),
                    decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(AppStrings.setTimeText,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                        fontWeight: FontWeight.bold)),
                            Switch(
                              value: _isSwitched[0],
                              onChanged: (value) {
                                setState(() {
                                  _isSwitched[0] = value;
                                });
                              },
                              activeColor:
                                  Colors.white, // Circle color (active)
                              activeTrackColor: const Color(
                                  0xFF34C759), // Track color (active)
                              inactiveThumbColor: AppColors
                                  .whiteColor, // Circle color (inactive)
                              inactiveTrackColor: AppColors
                                  .darkGrayColor, // Track color (inactive)
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                
                                Text(AppStrings.startTimeText,
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
                                              //   height: 3,
                                              //   width: 140,
                                              //   decoration: BoxDecoration(
                                              //     color: Colors.black,
                                              //     borderRadius:
                                              //         BorderRadius.circular(10),
                                              //   ),
                                              //   margin: const EdgeInsets.only(
                                              //       bottom: 8),
                                              // ),
                                              // const SizedBox(height: 40),
                                              // Text(AppStrings.genderText,
                                              //     style: Theme.of(context)
                                              //         .textTheme
                                              //         .titleLarge
                                              //         ?.copyWith(
                                              //             fontWeight:
                                              //                 FontWeight.bold)),
                                              // Expanded(
                                              //   child: CupertinoPicker(
                                              //     backgroundColor:
                                              //         AppColors.whiteColor,
                                              //     itemExtent: 40,
                                              //     onSelectedItemChanged:
                                              //         (int index) {
                                              //       gender = _genderList[index];
                                              //     },
                                              //     children: _genderList
                                              //         .map((gender) => Center(
                                              //               child: Text(
                                              //                 gender,
                                              //                 style: Theme.of(
                                              //                         context)
                                              //                     .textTheme
                                              //                     .bodyMedium,
                                              //               ),
                                              //             ))
                                              //         .toList(),
                                              //   ),
                                              // ),
                                              // const SizedBox(
                                              //   height: 24,
                                              // ),
                                              // Row(
                                              //     mainAxisAlignment:
                                              //         MainAxisAlignment
                                              //             .spaceBetween,
                                              //     children: [
                                              //       _buildCancleButton(),
                                              //       const SizedBox(width: 10),
                                              //       _buildConfirmButton()
                                              //     ]
                                              )
                                            ],
                                          ),
                                        ));
                                // if (result != null) {
                                //   setState(() {
                                //     gender = result as String;
                                //   });
                                // }
                              },
                              child: Row(
                                children: [
                                  Text('10:00', style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: AppColors.primaryColor)),
                                  SizedBox(width: 8),
                                  const Icon(
                                    Icons.navigate_next_rounded,
                                    color: AppColors.greyColor,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 27),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                
                                Text(AppStrings.endTimeText,
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
                                              //   height: 3,
                                              //   width: 140,
                                              //   decoration: BoxDecoration(
                                              //     color: Colors.black,
                                              //     borderRadius:
                                              //         BorderRadius.circular(10),
                                              //   ),
                                              //   margin: const EdgeInsets.only(
                                              //       bottom: 8),
                                              // ),
                                              // const SizedBox(height: 40),
                                              // Text(AppStrings.genderText,
                                              //     style: Theme.of(context)
                                              //         .textTheme
                                              //         .titleLarge
                                              //         ?.copyWith(
                                              //             fontWeight:
                                              //                 FontWeight.bold)),
                                              // Expanded(
                                              //   child: CupertinoPicker(
                                              //     backgroundColor:
                                              //         AppColors.whiteColor,
                                              //     itemExtent: 40,
                                              //     onSelectedItemChanged:
                                              //         (int index) {
                                              //       gender = _genderList[index];
                                              //     },
                                              //     children: _genderList
                                              //         .map((gender) => Center(
                                              //               child: Text(
                                              //                 gender,
                                              //                 style: Theme.of(
                                              //                         context)
                                              //                     .textTheme
                                              //                     .bodyMedium,
                                              //               ),
                                              //             ))
                                              //         .toList(),
                                              //   ),
                                              // ),
                                              // const SizedBox(
                                              //   height: 24,
                                              // ),
                                              // Row(
                                              //     mainAxisAlignment:
                                              //         MainAxisAlignment
                                              //             .spaceBetween,
                                              //     children: [
                                              //       _buildCancleButton(),
                                              //       const SizedBox(width: 10),
                                              //       _buildConfirmButton()
                                              //     ]
                                              )
                                            ],
                                          ),
                                        ));
                                // if (result != null) {
                                //   setState(() {
                                //     gender = result as String;
                                //   });
                                // }
                              },
                              child: Row(
                                children: [
                                  Text('22:00', style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: AppColors.primaryColor)),
                                  SizedBox(width: 8),
                                  const Icon(
                                    Icons.navigate_next_rounded,
                                    color: AppColors.greyColor,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 27),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                
                                Text(AppStrings.notiEveryText,
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
                                              //   height: 3,
                                              //   width: 140,
                                              //   decoration: BoxDecoration(
                                              //     color: Colors.black,
                                              //     borderRadius:
                                              //         BorderRadius.circular(10),
                                              //   ),
                                              //   margin: const EdgeInsets.only(
                                              //       bottom: 8),
                                              // ),
                                              // const SizedBox(height: 40),
                                              // Text(AppStrings.genderText,
                                              //     style: Theme.of(context)
                                              //         .textTheme
                                              //         .titleLarge
                                              //         ?.copyWith(
                                              //             fontWeight:
                                              //                 FontWeight.bold)),
                                              // Expanded(
                                              //   child: CupertinoPicker(
                                              //     backgroundColor:
                                              //         AppColors.whiteColor,
                                              //     itemExtent: 40,
                                              //     onSelectedItemChanged:
                                              //         (int index) {
                                              //       gender = _genderList[index];
                                              //     },
                                              //     children: _genderList
                                              //         .map((gender) => Center(
                                              //               child: Text(
                                              //                 gender,
                                              //                 style: Theme.of(
                                              //                         context)
                                              //                     .textTheme
                                              //                     .bodyMedium,
                                              //               ),
                                              //             ))
                                              //         .toList(),
                                              //   ),
                                              // ),
                                              // const SizedBox(
                                              //   height: 24,
                                              // ),
                                              // Row(
                                              //     mainAxisAlignment:
                                              //         MainAxisAlignment
                                              //             .spaceBetween,
                                              //     children: [
                                              //       _buildCancleButton(),
                                              //       const SizedBox(width: 10),
                                              //       _buildConfirmButton()
                                              //     ]
                                              )
                                            ],
                                          ),
                                        ));
                                // if (result != null) {
                                //   setState(() {
                                //     gender = result as String;
                                //   });
                                // }
                              },
                              child: Row(
                                children: [
                                  Text('1 ชม.', style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: AppColors.primaryColor)),
                                  SizedBox(width: 8),
                                  const Icon(
                                    Icons.navigate_next_rounded,
                                    color: AppColors.greyColor,
                                  ),
                                ],
                              ),
                            ),
                            
                          ],
                        ),
                        SizedBox(height: 11)
                      ],
                    ),
                  ),
                  
                  TextButton(onPressed: () {
                            context.goNamed(AppPages.logHistoryName);
                          },
                          
                          child: Text(AppStrings.drinkPlanText,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: AppColors.secondaryDarkColor)),
                        ),
                ],
              ),
              SizedBox(height: 36),
              // Sleep section
              Column(
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(AppImages.sleepingIcon, height: 21),
                      const SizedBox(width: 8),
                      Text(
                        AppStrings.sleepingText,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(height: 16),
                  
                  Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                    AppStrings.setTimeText,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
              Switch(
                value: _isSwitched[1],
                onChanged: (value) {
                  setState(() {
                    _isSwitched[1] = value;
                  });
                },
                activeColor: Colors.white, // Circle color (active)
                activeTrackColor:
                    const Color(0xFF34C759), // Track color (active)
                inactiveThumbColor:
                    AppColors.whiteColor, // Circle color (inactive)
                inactiveTrackColor:
                    AppColors.darkGrayColor, // Track color (inactive)
              ),
            ],
          ),
        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
