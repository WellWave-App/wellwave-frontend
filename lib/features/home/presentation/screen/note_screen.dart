import 'package:flutter/material.dart';
import 'package:flutter_ruler_picker/flutter_ruler_picker.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'note_history_screen.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoteScreen extends StatefulWidget {
  NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: TitleSection()),
      body: SingleChildScrollView(
        child: Column(
          children: [DailyLogs(), WeeklyLogs()],
        ),
      ),
    );
  }
}

class TitleSection extends StatelessWidget {
  TitleSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all<Color>(Colors.grey),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NoteHistoryScreen()),
            );
          },
          child: Text(
            'ประวัติ',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColors.greyColor,
                  // fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ],
    );
  }
}

class DailyLogs extends StatefulWidget {
  DailyLogs({super.key});

  @override
  State<DailyLogs> createState() => _DailyLogsState();
}

class _DailyLogsState extends State<DailyLogs> {
  int selectedWaterLevel = 0;
  int selectedSleepHours = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('บันทึกสุขภาพประจำวัน',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.blackColor, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // การดื่ม
              Expanded(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                  decoration: BoxDecoration(
                    color: AppColors.tertiaryColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Center(
                            child: Text('จำนวนน้ำ',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                        color: AppColors.primaryColor,
                                        fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Text('$selectedWaterLevel แก้ว',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                      color: AppColors.blackColor,
                                      fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: GestureDetector(
                                onTap: () async {
                                  int? result = await showDialog<int>(
                                    context: context,
                                    builder: (context) => WaterLevelDialog(
                                      initialGlasses: selectedWaterLevel,
                                    ),
                                  );
                                  if (result != null) {
                                    setState(() {
                                      selectedWaterLevel = result;
                                    });
                                  }
                                },
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    Icon(
                                      Icons.water_drop_rounded,
                                      color: Colors.blue.withOpacity(0.2),
                                      size: 86,
                                    ),
                                    Container(
                                      width: 25,
                                      height: 50 * (selectedWaterLevel / 8),
                                      color: Colors.blue,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 20),
              // การนอน
              Expanded(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                  decoration: BoxDecoration(
                    color: AppColors.tertiaryColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('ชั่วโมงการนอน',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Text('$selectedSleepHours ชั่วโมง',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                      color: AppColors.blackColor,
                                      fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: GestureDetector(
                                onTap: () async {
                                  int? result = await showDialog<int>(
                                    context: context,
                                    builder: (context) => SleepLevelDialog(
                                      initialHours: selectedSleepHours,
                                    ),
                                  );
                                  if (result != null) {
                                    setState(() {
                                      selectedSleepHours = result;
                                    });
                                  }
                                },
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    Icon(
                                      Icons.nights_stay,
                                      color: Colors.yellow.withOpacity(0.2),
                                      size: 82,
                                    ),
                                    Container(
                                      width: 25,
                                      height: 50 * (selectedSleepHours / 24),
                                      color: Colors.yellow,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class WeeklyLogs extends StatefulWidget {
  WeeklyLogs({super.key});

  @override
  State<WeeklyLogs> createState() => _WeeklyLogsState();
}

class _WeeklyLogsState extends State<WeeklyLogs> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text('ความก้าวหน้าประจำสัปดาห์',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    height: 32,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(
                                0.15), // Black shadow with 15% opacity
                            offset: Offset(0, 2), // Only on the bottom (Y-axis)
                            blurRadius: 0, // No blur
                          ),
                        ],
                      ),
                      child: TextButton(
                        style: ButtonStyle(
                          foregroundColor:
                              WidgetStateProperty.all<Color>(Colors.white),
                          backgroundColor: WidgetStateProperty.all<Color>(
                              AppColors.primaryColor),
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                              side: BorderSide(
                                  color: Colors.white,
                                  width: 2), // White stroke with thickness of 2
                            ),
                          ),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => DataEntryDialog(),
                          );
                        },
                        child: Row(
                          children: [
                            Icon(Icons.add, size: 16.0),
                            SizedBox(width: 4),
                            Text(
                              'บันทึกข้อมูล',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                    color: AppColors.whiteColor,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        offset: Offset(0, 0),
                        blurRadius: 4,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'น้ำหนัก',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            '50 ',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'กก.',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  color: AppColors.blackColor,
                                ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: LineChartSample2(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        offset: Offset(0, 0),
                        blurRadius: 4,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('HDL',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                      color: AppColors.blackColor,
                                      fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Text('65 ',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                      color: AppColors.blackColor,
                                      fontWeight: FontWeight.bold)),
                          Text('มก./ดล',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                    color: AppColors.blackColor,
                                  )),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Expanded(
                            child: LineChartSample2(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        offset: Offset(0, 0),
                        blurRadius: 4,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('LDL',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                      color: AppColors.blackColor,
                                      fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Text('165 ',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                      color: AppColors.blackColor,
                                      fontWeight: FontWeight.bold)),
                          Text('มก./ดล',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                    color: AppColors.blackColor,
                                  )),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Expanded(
                            child: LineChartSample2(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//water logs
class WaterLevelDialog extends StatefulWidget {
  final int initialGlasses;

  WaterLevelDialog({required this.initialGlasses});
  @override
  _WaterLevelDialogState createState() => _WaterLevelDialogState();
}

class _WaterLevelDialogState extends State<WaterLevelDialog> {
  late int waterLevel;

  @override
  void initState() {
    super.initState();
    waterLevel = widget.initialGlasses;
  }

  void increaseWaterLevel() {
    setState(() {
      if (waterLevel < 8) {
        waterLevel++;
      }
    });
  }

  void decreaseWaterLevel() {
    setState(() {
      if (waterLevel > 0) {
        waterLevel--;
      }
    });
  }

  double calculateWaterHeight() {
    return waterLevel / 8.0;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text('จำนวนน้ำ',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.blackColor, fontWeight: FontWeight.bold)),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Icon(Icons.water_drop_rounded,
                  color: Colors.blue.withOpacity(0.2),
                  size: 100), // ไอคอนน้ำที่ว่างเปล่า
              Container(
                width: 50,
                height: 100 *
                    calculateWaterHeight(), // ความสูงของน้ำตามระดับที่กำหนด
                color: Colors.blue,
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.remove_circle_outline,
                    color: Colors.grey, size: 48),
                onPressed: decreaseWaterLevel,
              ),
              SizedBox(width: 24.0),
              Text('$waterLevel',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.bold)),
              SizedBox(width: 24.0),
              IconButton(
                icon: Icon(Icons.add_circle_outline,
                    color: Colors.grey, size: 48),
                onPressed: increaseWaterLevel,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('แก้ว',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppColors.greyColor,
                      )),
            ],
          )
        ],
      ),
      actions: [
        TextButton(
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
            backgroundColor:
                WidgetStateProperty.all<Color>(AppColors.primaryColor),
          ),
          onPressed: () => Navigator.pop(context, waterLevel),
          child: Center(child: Text('ยืนยัน')),
        ),
      ],
    );
  }
}

//sleep logs
class SleepLevelDialog extends StatefulWidget {
  final int initialHours;

  SleepLevelDialog({required this.initialHours});

  @override
  _SleepLevelDialogState createState() => _SleepLevelDialogState();
}

class _SleepLevelDialogState extends State<SleepLevelDialog> {
  late int sleepHours;

  @override
  void initState() {
    super.initState();
    sleepHours = widget.initialHours;
  }

  void increaseSleepHours() {
    setState(() {
      if (sleepHours < 24) {
        sleepHours++;
      }
    });
  }

  void decreaseSleepHours() {
    setState(() {
      if (sleepHours > 0) {
        sleepHours--;
      }
    });
  }

  double calculateSleepHeight() {
    return sleepHours / 24.0;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text('ชั่วโมงการนอน',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.blackColor, fontWeight: FontWeight.bold)),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Icon(
                Icons.nights_stay,
                color: Colors.yellow.withOpacity(0.2),
                size: 100,
              ),
              Container(
                width: 50,
                height: 100 * calculateSleepHeight(),
                color: Colors.yellow,
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.remove_circle_outline,
                    color: Colors.grey, size: 48),
                onPressed: decreaseSleepHours,
              ),
              SizedBox(width: 24.0),
              Text('$sleepHours',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.bold)),
              SizedBox(width: 24.0),
              IconButton(
                icon: Icon(Icons.add_circle_outline,
                    color: Colors.grey, size: 48),
                onPressed: increaseSleepHours,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('ชั่วโมง',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppColors.greyColor,
                      )),
            ],
          )
        ],
      ),
      actions: [
        TextButton(
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
            backgroundColor:
                WidgetStateProperty.all<Color>(AppColors.primaryColor),
          ),
          onPressed: () => Navigator.pop(context, sleepHours),
          child: Center(child: Text('ยืนยัน')),
        ),
      ],
    );
  }
}

//บันทึกข้อมูล

class DataEntryDialog extends StatefulWidget {
  @override
  _DataEntryDialogState createState() => _DataEntryDialogState();
}

class _DataEntryDialogState extends State<DataEntryDialog> {
  int currentStep = 0;
  num weight = 50.0;
  num hdl = 60.0;
  num ldl = 100.0;
  int selectedMood = 0;

  final List<IconData> moodIcons = [
    Icons.sentiment_very_dissatisfied,
    Icons.sentiment_dissatisfied,
    Icons.sentiment_neutral,
    Icons.sentiment_satisfied,
    Icons.sentiment_very_satisfied,
  ];

  final RulerPickerController weightController =
      RulerPickerController(value: 50.0);
  final RulerPickerController hdlController =
      RulerPickerController(value: 60.0);
  final RulerPickerController ldlController =
      RulerPickerController(value: 100.0);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: currentStep == 4
          ? Text('')
          : Text('ขั้นตอนที่ ${currentStep + 1}/4',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.blackColor, fontWeight: FontWeight.bold)),
      content: _buildStepContent(),
      actions: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _buildActions(),
          ),
        ),
      ],
      backgroundColor: AppColors.popupColor,
    );
  }

  Widget _buildStepContent() {
    switch (currentStep) {
      case 0:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('บันทึกค่าน้ำหนัก'),
              ],
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('$weight ',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.bold)),
                Text('กก.',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: AppColors.greyColor,
                        )),
              ],
            ),
            RulerPicker(
              controller: weightController,
              onValueChanged: (value) {
                setState(() {
                  weight = value;
                });
              },
              ranges: const [
                RulerRange(begin: 30, end: 150, scale: 1),
              ],
              width: MediaQuery.of(context).size.width * 0.8,
              height: 80,
              rulerBackgroundColor: Colors.transparent,
              onBuildRulerScaleText: (index, value) {
                return value.toStringAsFixed(1);
              },
            ),
          ],
        );
      case 1:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('บันทึกค่า HDL'),
              ],
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('$hdl ',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.bold)),
                Text('มก./ดล',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: AppColors.greyColor,
                        )),
              ],
            ),
            RulerPicker(
              controller: hdlController,
              onValueChanged: (value) {
                setState(() {
                  hdl = value;
                });
              },
              ranges: const [
                RulerRange(begin: 0, end: 150, scale: 1),
              ],
              width: MediaQuery.of(context).size.width * 0.8,
              height: 80,
              rulerBackgroundColor: Colors.transparent,
              onBuildRulerScaleText: (index, value) {
                return value.toStringAsFixed(1);
              },
            ),
          ],
        );
      case 2:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('บันทึกค่า LDL'),
              ],
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('$ldl ',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.bold)),
                Text('มก./ดล',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: AppColors.greyColor,
                        )),
              ],
            ),
            RulerPicker(
              controller: ldlController,
              onValueChanged: (value) {
                setState(() {
                  ldl = value;
                });
              },
              ranges: const [
                RulerRange(begin: 100, end: 300, scale: 1),
              ],
              width: MediaQuery.of(context).size.width * 0.8,
              height: 80,
              rulerBackgroundColor: Colors.transparent,
              onBuildRulerScaleText: (index, value) {
                return value.toStringAsFixed(1);
              },
            ),
          ],
        );
      case 3:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('เลือกอารมณ์'),
              ],
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(moodIcons.length, (index) {
                return IconButton(
                  icon: Icon(
                    moodIcons[index],
                    color: selectedMood == index ? Colors.blue : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      selectedMood = index;
                    });
                  },
                );
              }),
            ),
          ],
        );
      case 4:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Display the SVG
            SvgPicture.string(
              '''
        <svg width="113" height="112" viewBox="0 0 113 112" fill="none" xmlns="http://www.w3.org/2000/svg">
          <rect x="0.5" width="112" height="112" rx="56" fill="url(#paint0_linear_162_3119)"/>
          <path fill-rule="evenodd" clip-rule="evenodd" d="M85.9992 36.4256C87.7279 38.2367 87.6612 41.1063 85.8501 42.835L51.629 75.7226C50.7455 76.5659 49.559 77.0171 48.3383 76.9738C47.1177 76.9306 45.9661 76.3966 45.1445 75.4928L28.4251 57.4414C26.7409 55.5888 26.8774 52.7217 28.73 51.0375C30.5826 49.3534 33.4497 49.4899 35.1339 51.3425L48.7287 65.9569L79.5898 36.2766C81.4009 34.5479 84.2705 34.6146 85.9992 36.4256Z" fill="#F6F8FC"/>
          <defs>
            <linearGradient id="paint0_linear_162_3119" x1="0.5" y1="56" x2="112.5" y2="56" gradientUnits="userSpaceOnUse">
              <stop stop-color="#4874D7"/>
              <stop offset="1" stop-color="#1D3E88"/>
            </linearGradient>
          </defs>
        </svg>
        ''',
              width: 80, // Set the width
              height: 80, // Set the height
            ),
            SizedBox(height: 8), // Space between the SVG and text
            Text('บันทึกข้อมูลเสร็จสิ้น',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.blackColor, fontWeight: FontWeight.bold))
          ],
        );
      default:
        return Container();
    }
  }

  List<Widget> _buildActions() {
    return [
      Expanded(
        child: TextButton(
          onPressed: () {
            if (currentStep == 4) {
              Navigator.pop(context);
            } else {
              setState(() {
                currentStep = 0;
              });
              Navigator.pop(context);
            }
          },
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(currentStep == 4
                ? AppColors.primaryColor
                : Colors.transparent), // Blue if finished
            side: WidgetStateProperty.all(
                BorderSide(color: AppColors.primaryColor)), // Blue border
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40), // Rounded corners
              ),
            ),
          ),
          child: Text(
            currentStep == 4 ? 'เสร็จสิ้น' : 'ยกเลิก',
            style: TextStyle(
                color: currentStep == 4
                    ? Colors.white
                    : AppColors
                        .primaryColor), // Change text color based on state
          ),
        ),
      ),
      SizedBox(width: 8),
      // Next or Confirm Button
      if (currentStep < 4)
        Expanded(
          child: TextButton(
            onPressed: () {
              setState(() {
                currentStep++;
              });
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                  AppColors.primaryColor), // Blue background
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40), // Rounded corners
                ),
              ),
            ),
            child: Text(
              currentStep == 3 ? 'ยืนยัน' : 'ถัดไป',
              style: TextStyle(
                  color: Colors.white), // White text color for blue buttons
            ),
          ),
        ),
    ];
  }
}

//chart
class LineChartSample2 extends StatefulWidget {
  const LineChartSample2({super.key});

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    Color(0xFFADB7F9),
    Color.fromARGB(0, 177, 185, 248),
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
            child: LineChart(
              showAvg ? avgData() : mainData(),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              showAvg = !showAvg;
            });
          },
          child: Text(
            'avg',
            style: TextStyle(
              fontSize: 12,
              color: showAvg
                  ? Colors.white.withOpacity(0)
                  : AppColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontSize: 10,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('14-08', style: style);
        break;
      case 4:
        text = const Text('21-08', style: style);
        break;
      case 8:
        text = const Text('27-08', style: style);
        break;
      case 11:
        text = const Text('03-09', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        drawHorizontalLine: false,
        verticalInterval: 4,
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Color(0xFFB1B1B1),
            strokeWidth: 0.5,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border(
          left: BorderSide(color: Color(0xFFB1B1B1), width: 0.5), // Left border
          right:
              BorderSide(color: Color(0xFFB1B1B1), width: 0.5), // Right border
        ),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
          ],
          isCurved: true,
          color: const Color(0xFF001DFF),
          barWidth: 1,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topCenter, // Start at the top
              end: Alignment.bottomCenter, // End at the bottom
            ),
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: const LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        drawHorizontalLine: false,
        verticalInterval: 4,
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Color(0xFFB1B1B1),
            strokeWidth: 0.5,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border(
          left: BorderSide(color: Color(0xFFB1B1B1), width: 0.5), // Left border
          right:
              BorderSide(color: Color(0xFFB1B1B1), width: 0.5), // Right border
        ),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ],
          isCurved: true,
          color: const Color(0xFF001DFF),
          barWidth: 1,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topCenter, // Start at the top
              end: Alignment.bottomCenter, // End at the bottom
            ),
          ),
        ),
      ],
    );
  }
}
