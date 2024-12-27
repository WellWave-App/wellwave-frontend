import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_pages.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';

class NotificationDrinking extends StatefulWidget {
  const NotificationDrinking({super.key});

  @override
  State<NotificationDrinking> createState() => _NotificationDrinkingState();
}

class _NotificationDrinkingState extends State<NotificationDrinking> {
  bool _isSwitched = false;
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();

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
          child: Text(AppStrings.backText,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.primaryColor)),
        ),
      ),
    );
  }

  void _submitLogs() {
    // final logsBloc = BlocProvider.of<LogsBloc>(context);

    // String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

    final logEvents = [
      //   SubmitLogEvent(
      //     logName: AppStrings.weightLogText,
      //     value: weight.toInt(),
      //     selectedDate: formattedDate,
      //   ),
      //   SubmitLogEvent(
      //     logName: AppStrings.waistLineLogText,
      //     value: waistLine.toInt(),
      //     selectedDate: formattedDate,
      //   ),
      //   if (isRecordHDL)
      //     SubmitLogEvent(
      //       logName: AppStrings.hdlLogText,
      //       value: hdl.toInt(),
      //       selectedDate: formattedDate,
      //     )
      // ];

      // for (var event in logEvents) {
      //   logsBloc.add(event);
      // }
    ];
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
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
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  Switch(
                    value: _isSwitched,
                    onChanged: (value) {
                      setState(() {
                        _isSwitched = value;
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
                                      height: 3,
                                      width: 140,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      margin: const EdgeInsets.only(bottom: 8),
                                    ),
                                    const SizedBox(height: 40),
                                    Expanded(
                                      child: CupertinoDatePicker(
                                        initialDateTime: startTime,
                                        mode: CupertinoDatePickerMode.time,
                                        use24hFormat: true,
                                        onDateTimeChanged: (DateTime newTime) {
                                          setState(() => startTime = newTime);
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                      //     time = result;
                      //   });
                      // }
                    },
                    child: Row(
                      children: [
                        Text(
                            '${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: AppColors.primaryColor)),
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
                                      height: 3,
                                      width: 140,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      margin: const EdgeInsets.only(bottom: 8),
                                    ),
                                    const SizedBox(height: 40),
                                    Expanded(
                                      child: CupertinoDatePicker(
                                        initialDateTime: endTime,
                                        mode: CupertinoDatePickerMode.time,
                                        use24hFormat: true,
                                        onDateTimeChanged: (DateTime newTime) {
                                          setState(() => endTime = newTime);
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                      //     time = result;
                      //   });
                      // }
                    },
                    child: Row(
                      children: [
                        Text(
                            '${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: AppColors.primaryColor)),
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
                        Text('1 ชม.',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: AppColors.primaryColor)),
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
              const SizedBox(height: 11)
            ],
          ),
        ),
        TextButton(
          onPressed: () {
            context.goNamed(AppPages.drinkPlanName);
          },
          child: Text(AppStrings.setDrinkPlanText,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: AppColors.secondaryDarkColor)),
        ),
      ],
    );
  }
}
