import 'package:flutter/material.dart';

class NoteScreen extends StatefulWidget {
  NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  @override
  Widget build(BuildContext context) {
    String appTitle = 'To do list';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(title: TitleSection()),
        body: SingleChildScrollView(
          child: Column(
            children: [DailyLogs(), WeeklyLogs()],
          ),
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
    return Padding(
      padding: EdgeInsets.all(32),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.end, // Aligns the content to the start (left)
        children: [
          TextButton(
            style: ButtonStyle(
              foregroundColor: WidgetStateProperty.all<Color>(Colors.blue),
            ),
            onPressed: () {},
            child: Text('ประวัติ',
                style: Theme.of(context).textTheme.headlineLarge),
          ),
        ],
      ),
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
      padding: EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('บันทึกสุขภาพประจำวัน',
              style: Theme.of(context).textTheme.headlineLarge),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // การดื่ม
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 8),
                          Text('จำนวนน้ำ'),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(width: 8),
                          Text('$selectedWaterLevel แก้ว'),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(width: 8),
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
                                      size: 50,
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
                          SizedBox(width: 8),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 20), // ระยะห่างระหว่างคอลัมน์
              // การนอน
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue[50], // สีพื้นหลังของคอลัมน์แรก
                    borderRadius: BorderRadius.circular(15), // ทำขอบมน
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 8),
                          Text('ชั่วโมงการนอน'),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(width: 8),
                          Text('$selectedSleepHours ชั่วโมง'),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(width: 8),
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
                                      size: 50,
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
      padding: EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'ความก้าวหน้าประจำสัปดาห์',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                children: [
                  TextButton(
                    style: ButtonStyle(
                        foregroundColor:
                            WidgetStateProperty.all<Color>(Colors.white),
                        backgroundColor: WidgetStatePropertyAll(Colors.blue)),
                    onPressed: () {},
                    child: Row(
                      children: [
                        Icon(Icons.add),
                        Text('บันทึกข้อมูล'),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // คอลัมน์แรก
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue[50], // สีพื้นหลังของคอลัมน์แรก
                    borderRadius: BorderRadius.circular(15), // ทำขอบมน
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 8),
                          Text('น้ำหนัก'),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(width: 8),
                          Text('50 กก.'),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(width: 8),
                          Icon(Icons.water_drop_rounded, color: Colors.blue),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // คอลัมน์แรก
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue[50], // สีพื้นหลังของคอลัมน์แรก
                    borderRadius: BorderRadius.circular(15), // ทำขอบมน
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 8),
                          Text('HDL'),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(width: 8),
                          Text('65 มก./ดล.'),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(width: 8),
                          Icon(Icons.water_drop_rounded, color: Colors.blue),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 20), // ระยะห่างระหว่างคอลัมน์
              // คอลัมน์ที่สอง
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue[50], // สีพื้นหลังของคอลัมน์แรก
                    borderRadius: BorderRadius.circular(15), // ทำขอบมน
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 8),
                          Text('LDL'),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(width: 8),
                          Text('65 มก./ดล.'),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(width: 8),
                          Icon(Icons.mood, color: Colors.yellow),
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
      title: Text('จำนวนน้ำ'),
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
                icon: Icon(Icons.remove),
                onPressed: decreaseWaterLevel,
              ),
              Text(
                '$waterLevel',
                style: TextStyle(fontSize: 24),
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: increaseWaterLevel,
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
            backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
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
      title: Text('ชั่วโมงการนอน'),
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
                icon: Icon(Icons.remove),
                onPressed: decreaseSleepHours,
              ),
              Text(
                '$sleepHours',
                style: TextStyle(fontSize: 24),
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: increaseSleepHours,
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
            backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
          ),
          onPressed: () => Navigator.pop(context, sleepHours),
          child: Text('ยืนยัน'),
        ),
      ],
    );
  }
}
