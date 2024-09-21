import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';

class CheckInWidget extends StatefulWidget {
  final int currentDay; 
  const CheckInWidget({Key? key, required this.currentDay}) : super(key: key);

  @override
  _CheckInWidgetState createState() => _CheckInWidgetState();
}

class _CheckInWidgetState extends State<CheckInWidget> {
  List<bool> checkedInDays = [false, false, false, false, false, false, false];
  final List<int> gemPoints = [20, 20, 20, 20, 20, 20, 100];

  void _checkIn(int dayIndex) {
    
    if (dayIndex == widget.currentDay && !checkedInDays[dayIndex]) {
      setState(() {
        checkedInDays[dayIndex] = true;
      });
      // Reward the user gems
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You earned ${gemPoints[dayIndex]} gems!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.checkinText,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (index) {
              
              return Column(
                children: [
                  GestureDetector(
                    onTap: () => _checkIn(index),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: checkedInDays[index] 
                          ? Colors.black
                          : Colors.white,
                      child: checkedInDays[index]
                          ? const Icon(
                              Icons.check,
                              color: Colors.white,
                            )
                          : Text(
                              '${gemPoints[index]}',
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold, color: index == widget.currentDay
                                    ? Colors.blue
                                    : Colors.black,
                ),
                              
                            ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text('${AppStrings.xdayText} ${index + 1}', style: Theme.of(context).textTheme.caption2?.copyWith()),
                ],
              );
            }),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
