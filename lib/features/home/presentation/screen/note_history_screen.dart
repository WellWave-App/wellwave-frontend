import 'dart:math';
import 'package:flutter/material.dart';
import 'package:calendar_slider/calendar_slider.dart';

class NoteHistoryScreen extends StatefulWidget {
  const NoteHistoryScreen({super.key});

  @override
  State<NoteHistoryScreen> createState() => _NoteHistoryScreenState();
}

class _NoteHistoryScreenState extends State<NoteHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: TitleSection()),
      body: SingleChildScrollView(
        child: Column(
          children: [CalendarSilder(), DailyLogs(), WeeklyLogs()],
        ),
      ),
    );
  }
}

class TitleSection extends StatelessWidget {
  const TitleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'ประวัติบันทึกสุขภาพ',
      // style: TextStyle(
      //   color: Colors.white, // Sets the text color to white
      //   fontSize: 20, // Adjust the font size as needed
      //   fontWeight: FontWeight.bold, // Makes the text bold
    
    );
  }
}

// CalendarSilder widget
class CalendarSilder extends StatefulWidget {
  const CalendarSilder({Key? key}) : super(key: key);

  @override
  State<CalendarSilder> createState() => _CalendarSilderState();
}

class _CalendarSilderState extends State<CalendarSilder> {
  final CalendarSliderController _firstController = CalendarSliderController();

  Random random = Random();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CalendarSlider(
          controller: _firstController,
          selectedDayPosition: SelectedDayPosition.center,
          fullCalendarScroll: FullCalendarScroll.vertical,
          backgroundColor: Colors.lightBlue,
          fullCalendarWeekDay: WeekDay.short,
          selectedTileBackgroundColor: const Color.fromARGB(255, 0, 213, 195),
          monthYearButtonBackgroundColor: Colors.transparent,
          monthYearTextColor: Colors.black,
          tileBackgroundColor: Colors.lightBlue,
          selectedDateColor: Colors.black,
          dateColor: Colors.white,
          tileShadow: BoxShadow(
            color: Colors.black.withOpacity(1),
          ),
          locale: 'en',
          initialDate: DateTime.now(),
          firstDate: DateTime.now().subtract(const Duration(days: 100)),
          lastDate: DateTime.now().add(const Duration(days: 100)),
          onDateSelected: (date) {
            setState(() {});
          },
        ),
        Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  _firstController.goToDay(DateTime.now());
                },
                child: const Text("Go to today"),
              ),
              const SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

//log

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
          Text('บันทึกสุขภาพประจำวัน'),
          SizedBox(height: 20),
          Row(
            children: [
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
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20), // ระยะห่างระหว่างคอลัมน์
          // การนอน
          Row(
            children: [
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
            ],
          ),
          SizedBox(height: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
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
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
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
            ],
          ),
          SizedBox(height: 20), // ระยะห่างระหว่างคอลัมน์
          
          Row(
            children: [
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
