import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_pages.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/profile/presentation/bloc/notification/noti_bloc.dart';

class NotificationDrinking extends StatefulWidget {
  const NotificationDrinking({super.key});

  @override
  State<NotificationDrinking> createState() => _NotificationDrinkingState();
}

class _NotificationDrinkingState extends State<NotificationDrinking> {
  bool _isSwitched = false;
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();
  String hourSet = '1';
  final List<String> _hoursList = <String>[
    '0.5',
    '1',
    '1.5',
    '2',
    '2.5',
    '3',
  ];
  int intervalMinute = 60;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<NotiBloc>(context).add(FetchDrinkRangeEvent());
  }

  void _toggleSwitch(bool value) {
    if (_isSwitched != value) {
      setState(() {
        _isSwitched = value;
      });

      context.read<NotiBloc>().add(
          UpdateDrinkRangeEvent(uid: AppStrings.uid, isActive: _isSwitched));
    }
  }

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
    String formattedtimeStarttime = DateFormat('HH:mm').format(startTime);
    String formattedtimeEndtime = DateFormat('HH:mm').format(endTime);
    int intervalMinute = (double.parse(hourSet) * 60).toInt();

    context.read<NotiBloc>().add(CreateDrinkRangeEvent(
          uid: AppStrings.uid,
          startTime: formattedtimeStarttime,
          endTime: formattedtimeEndtime,
          intervalMinute: intervalMinute,
        ));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    context.read<NotiBloc>().add(
          FetchDrinkRangeEvent(),
        );
    return BlocListener<NotiBloc, NotiState>(
      listener: (context, state) {
        if (state is DrinkRangeState) {
          setState(() {
            _isSwitched = state.isActive;
            if (state.startTime.isNotEmpty) {
              startTime = DateFormat("HH:mm").parse(state.startTime);
            }
            if (state.endTime.isNotEmpty) {
              endTime = DateFormat("HH:mm").parse(state.endTime);
            }
            if (state.intervalMinute != 0) {
              intervalMinute = state.intervalMinute;
            }
          });
        }
      },
      child: BlocBuilder<NotiBloc, NotiState>(
        builder: (context, state) {
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
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
                              _toggleSwitch(value);
                            });
                          },
                          activeColor: Colors.white,
                          activeTrackColor: const Color(0xFF34C759),
                          inactiveThumbColor: AppColors.whiteColor,
                          inactiveTrackColor: AppColors.darkGrayColor,
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
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            margin: const EdgeInsets.only(
                                                bottom: 8),
                                          ),
                                          const SizedBox(height: 40),
                                          Expanded(
                                            child: CupertinoDatePicker(
                                              initialDateTime: startTime,
                                              mode:
                                                  CupertinoDatePickerMode.time,
                                              use24hFormat: true,
                                              onDateTimeChanged:
                                                  (DateTime newTime) {
                                                setState(
                                                    () => startTime = newTime);
                                              },
                                            ),
                                          ),
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
                            if (result != null) {
                              setState(() {
                                startTime = result as DateTime;
                              });
                            }
                          },
                          child: Row(
                            children: [
                              Text(
                                  '${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          color: AppColors.primaryColor)),
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
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            margin: const EdgeInsets.only(
                                                bottom: 8),
                                          ),
                                          const SizedBox(height: 40),
                                          Expanded(
                                            child: CupertinoDatePicker(
                                              initialDateTime: endTime,
                                              mode:
                                                  CupertinoDatePickerMode.time,
                                              use24hFormat: true,
                                              onDateTimeChanged:
                                                  (DateTime newTime) {
                                                setState(
                                                    () => endTime = newTime);
                                              },
                                            ),
                                          ),
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
                            if (result != null) {
                              setState(() {
                                endTime = result as DateTime;
                              });
                            }
                          },
                          child: Row(
                            children: [
                              Text(
                                  '${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          color: AppColors.primaryColor)),
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
                                        mainAxisSize: MainAxisSize.min,
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
                                          Expanded(
                                            child: CupertinoPicker(
                                              backgroundColor:
                                                  AppColors.whiteColor,
                                              itemExtent: 40,
                                              onSelectedItemChanged:
                                                  (int index) {
                                                hourSet = _hoursList[index];
                                              },
                                              children: _hoursList
                                                  .map((hourSet) => Center(
                                                        child: Text(
                                                          hourSet,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium,
                                                        ),
                                                      ))
                                                  .toList(),
                                            ),
                                          ),
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
                            if (result != null) {
                              setState(() {
                                hourSet = result as String;
                              });
                            }
                          },
                          child: Row(
                            children: [
                              Text('$hourSet ชม.',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          color: AppColors.primaryColor)),
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
        },
      ),
    );
  }
}
