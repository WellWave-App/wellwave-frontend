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
                          const Text('จำนวนน้ำ'),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const SizedBox(width: 8),
                          const Text('3 แก้ว'),
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
                          const Text('ชั่วโมงการนอน'),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const SizedBox(width: 8),
                          const Text('12 ชั่วโมง'),
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
                          WidgetStateProperty.all<Color>(Colors.blue),
                    ),
                    onPressed: () {},
                    child: Text('บันทึกข้อมูล'),
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
