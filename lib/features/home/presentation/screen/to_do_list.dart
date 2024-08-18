import 'package:flutter/material.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  @override
  Widget build(BuildContext context) {
    const String appTitle = 'To do list';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(title: const TitleSection()),
        body: const SingleChildScrollView(
          child: Column(
            children: [DailyLogs(), WeeklyLogs()],
          ),
        ),
      ),
    );
  }
}

class TitleSection extends StatelessWidget {
  const TitleSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.end, // Aligns the content to the start (left)
        children: [
          TextButton(
            style: ButtonStyle(
              foregroundColor: WidgetStateProperty.all<Color>(Colors.blue),
            ),
            onPressed: () {},
            child: Text('ประวัติ'),
          )
        ],
      ),
    );
  }
}

class DailyLogs extends StatefulWidget {
  const DailyLogs({super.key});

  @override
  State<DailyLogs> createState() => _DailyLogsState();
}

class _DailyLogsState extends State<DailyLogs> {
  int selectedWaterLevel = 0;
  int selectedSleepHours = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'บันทึกสุขภาพประจำวัน',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // การดื่ม
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 8),
                          const Text('จำนวนน้ำ'),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const SizedBox(width: 8),
                          Text('$selectedWaterLevel แก้ว'),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const SizedBox(width: 8),
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
                          const SizedBox(width: 8),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 20), // ระยะห่างระหว่างคอลัมน์
              // การนอน
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue[50], // สีพื้นหลังของคอลัมน์แรก
                    borderRadius: BorderRadius.circular(15), // ทำขอบมน
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 8),
                          const Text('ชั่วโมงการนอน'),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const SizedBox(width: 8),
                          Text('$selectedSleepHours ชั่วโมง'),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const SizedBox(width: 8),
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
  const WeeklyLogs({super.key});

  @override
  State<WeeklyLogs> createState() => _WeeklyLogsState();
}

class _WeeklyLogsState extends State<WeeklyLogs> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
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
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // คอลัมน์แรก
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue[50], // สีพื้นหลังของคอลัมน์แรก
                    borderRadius: BorderRadius.circular(15), // ทำขอบมน
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 8),
                          const Text('น้ำหนัก'),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const SizedBox(width: 8),
                          const Text('50 กก.'),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const SizedBox(width: 8),
                          Icon(Icons.water_drop_rounded, color: Colors.blue),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // คอลัมน์แรก
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue[50], // สีพื้นหลังของคอลัมน์แรก
                    borderRadius: BorderRadius.circular(15), // ทำขอบมน
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 8),
                          const Text('HDL'),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const SizedBox(width: 8),
                          const Text('65 มก./ดล.'),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const SizedBox(width: 8),
                          Icon(Icons.water_drop_rounded, color: Colors.blue),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 20), // ระยะห่างระหว่างคอลัมน์
              // คอลัมน์ที่สอง
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue[50], // สีพื้นหลังของคอลัมน์แรก
                    borderRadius: BorderRadius.circular(15), // ทำขอบมน
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 8),
                          const Text('LDL'),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const SizedBox(width: 8),
                          const Text('65 มก./ดล.'),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const SizedBox(width: 8),
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

  const WaterLevelDialog({required this.initialGlasses});
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
      title: const Text('จำนวนน้ำ'),
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
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: decreaseWaterLevel,
              ),
              Text(
                '$waterLevel',
                style: const TextStyle(fontSize: 24),
              ),
              IconButton(
                icon: const Icon(Icons.add),
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
          child: Center(child: const Text('ยืนยัน')),
        ),
      ],
    );
  }
}

//sleep logs
class SleepLevelDialog extends StatefulWidget {
  final int initialHours;

  const SleepLevelDialog({required this.initialHours});

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
      title: const Text('ชั่วโมงการนอน'),
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
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: decreaseSleepHours,
              ),
              Text(
                '$sleepHours',
                style: const TextStyle(fontSize: 24),
              ),
              IconButton(
                icon: const Icon(Icons.add),
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
          child: const Text('ยืนยัน'),
        ),
      ],
    );
  }
}
