// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:percent_indicator/circular_percent_indicator.dart';
// import 'package:wellwave_frontend/common/widget/app_bar.dart';
// import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'dart:async';
import 'package:flutter/material.dart';

class MissionRecordPage extends StatefulWidget {
  @override
  _MissionRecordPageState createState() => _MissionRecordPageState();
}

class _MissionRecordPageState extends State<MissionRecordPage> {
  final Stream<int> timerStream = (() {
    return Stream<int>.periodic(Duration(seconds: 1), (count) {
      return count;
    });
  })();

  // Function to convert seconds to hh:mm:ss
  String formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int secs = seconds % 60;
    return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Circular Timer with Rounded Edges"),
      ),
      body: Center(
        child: StreamBuilder<int>(
          stream: timerStream,
          builder: (context, snapshot) {
            int elapsedSeconds = snapshot.data ?? 0;
            double percent = (elapsedSeconds % 60) / 60; // Calculate percentage
            String timeString = formatTime(elapsedSeconds);
            int cycle = elapsedSeconds ~/ 60;

            // Define colors to display
            List<Color> colors = [
              Colors.green,
              Colors.blue,
            ];

            return Stack(
              alignment: Alignment.center,
              children: [
                // Background CircularProgressIndicator (full circle)
                Container(
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[300],
                  ),
                  child: CircularProgressIndicator(
                    value: 1.0, // Full circle
                    strokeCap: StrokeCap.round,
                    strokeWidth: 24.0,
                    backgroundColor: Colors.transparent,
                  ),
                ),
                // Foreground CircularProgressIndicator (percentage)
                Container(
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                  ),
                  child: CircularProgressIndicator(
                    value: percent,
                    strokeWidth: 24.0,
                    strokeCap: StrokeCap.round,
                    valueColor:
                        AlwaysStoppedAnimation(colors[cycle % colors.length]),
                    backgroundColor: Colors.transparent,
                  ),
                ),
                // Display the time in the center
                Center(
                  child: Text(
                    timeString,
                    style: TextStyle(fontSize: 24.0),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
// class MissionRecordPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         context: context,
//         backgroundColor: AppColors.whiteColor,
//         onLeading: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             // Circular Progress Bar with Timer
//             CircularProgressIndicatorWithRoundedEdges(
//               value: 1,
//             ),

//             SizedBox(height: 40),

//             // Pause and Finish buttons
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {},
//                   child: Row(
//                     children: [
//                       Icon(Icons.pause),
//                       SizedBox(width: 4),
//                       Text('หยุดพัก'),
//                     ],
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blueGrey[200],
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 20),
//                 ElevatedButton(
//                   onPressed: () {},
//                   child: Row(
//                     children: [
//                       Icon(Icons.check),
//                       SizedBox(width: 4),
//                       Text('เสร็จสิ้น'),
//                     ],
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue[300],
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                   ),
//                 ),
//               ],
//             ),

//             Spacer(),

//             // Recommendation Section
//             // RecommendationSection(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CircularProgressIndicatorWithRoundedEdges extends StatelessWidget {
//   final double value; // Progress value between 0 and 1

//   CircularProgressIndicatorWithRoundedEdges({required this.value});

//   @override
//   Widget build(BuildContext context) {
//     double percentage = 1.5; // ค่าที่มากกว่า 100%

//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(
//             vertical: 20.0), // ปรับขนาดตามความเหมาะสม
//         child: Column(
//           mainAxisSize: MainAxisSize.min, // ทำให้ Column ขยายตามขนาดลูก
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Text(
//             //   'ระยะเวลา',
//             //   style: TextStyle(fontSize: 18, color: Colors.grey[600]),
//             // ),
//             // Text(
//             //   '00:01:22', // Timer text can be dynamic
//             //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             // ),

//             CircularPercentIndicator(
//               radius: 100.0,
//               lineWidth: 10.0,
//               percent: percentage % 1, // นำค่าโมดูลัส 1
//               center: Text(
//                 "${(percentage * 100).toInt()}%", // แสดงค่าจริงแบบเกิน 100%
//                 style: TextStyle(fontSize: 24.0),
//               ),
//               progressColor: Colors.green,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// // class _CircularProgressPainter extends CustomPainter {
// //   final double value; // Progress value between 0 and 1

// //   _CircularProgressPainter(this.value);

// //   @override
// //   void paint(Canvas canvas, Size size) {
// //     // Define the center and radius for the circle
// //     final center = Offset(size.width / 2, size.height / 1.5);
// //     final radius = size.width / 1.6; // Adjust for padding

// //     // Background circle
// //     final backgroundPaint = Paint()
// //       ..color = Colors.grey[300]!
// //       ..style = PaintingStyle.stroke
// //       ..strokeWidth = 32;

// //     // Gradient for progress arc
// //     final gradient = LinearGradient(
// //       colors: [
// //         const Color.fromARGB(255, 123, 255, 127),
// //         Colors.blue,
// //       ],
// //       begin: Alignment.topCenter,
// //       end: Alignment.bottomCenter,
// //     );
// //     final rect = Rect.fromCircle(center: center, radius: radius);
// //     final gradientShader = gradient.createShader(rect);

// //     // Draw the background circle
// //     canvas.drawCircle(center, radius, backgroundPaint);

// //     // Draw the progress arc
// //     final progressPaint = Paint()
// //       ..shader = gradientShader
// //       ..style = PaintingStyle.stroke
// //       ..strokeWidth = 32
// //       ..strokeCap = StrokeCap.round;

// //     // Draw the progress arc
// //     final startAngle = -90 * pi / 180; // Start from the top
// //     final sweepAngle = 2 * pi * value; // Progress angle based on value
// //     canvas.drawArc(
// //       Rect.fromCircle(center: center, radius: radius),
// //       startAngle,
// //       sweepAngle,
// //       false,
// //       progressPaint,
// //     );

// //     // Calculate the position at the end of the arc for the heart icon
// //     final iconOffset = Offset(
// //       center.dx + radius * cos(startAngle + sweepAngle),
// //       center.dy + radius * sin(startAngle + sweepAngle),
// //     );

// //     // Calculate curve parameters
// // // Adjust this value as needed
// //     final curveRadius = 16.0; // Adjust the radius for curvature

// //     final curvePaint1 = Paint()
// //       ..color = const Color.fromARGB(255, 250, 250, 250)
// //           .withOpacity(0.2) // Light color for the bottom layer
// //       ..strokeWidth = 6 // Slightly thicker for more blur
// //       ..style = PaintingStyle.stroke
// //       ..maskFilter = MaskFilter.blur(BlurStyle.normal, 5); // Blur effect

// //     final curvePaint2 = Paint()
// //       ..color = Colors.white.withOpacity(0.8) // Main color for the top layer
// //       ..strokeWidth = 3 // Standard thickness
// //       ..style = PaintingStyle.stroke;

// // // Draw the blurred curve
// //     canvas.drawArc(
// //       Rect.fromCircle(center: iconOffset, radius: curveRadius),
// //       0, // Start angle of the arc
// //       pi, // Sweep angle (180 degrees)
// //       false, // Whether to use center
// //       curvePaint1, // Bottom paint with blur
// //     );

// // // Draw the main curve on top
// //     canvas.drawArc(
// //       Rect.fromCircle(center: iconOffset, radius: curveRadius),
// //       0, // Start angle of the arc
// //       pi, // Sweep angle (180 degrees)
// //       false, // Whether to use center
// //       curvePaint2, // Main paint
// //     );

// //     // Load the heart icon
// //     final heartIcon = Icons.local_fire_department;

// //     // Draw the heart icon at the end of the arc
// //     final textPainter = TextPainter(
// //       text: TextSpan(
// //         text: String.fromCharCode(heartIcon.codePoint),
// //         style: TextStyle(
// //           fontSize: 24.0,
// //           fontFamily: heartIcon.fontFamily,
// //           color: Colors.white,
// //         ),
// //       ),
// //       textDirection: TextDirection.ltr,
// //     );
// //     textPainter.layout();
// //     textPainter.paint(
// //       canvas,
// //       Offset(
// //         iconOffset.dx - textPainter.width / 2,
// //         iconOffset.dy - textPainter.height / 2,
// //       ),
// //     );
// //   }

// //   @override
// //   bool shouldRepaint(covariant CustomPainter oldDelegate) {
// //     return true; // Repaint when the progress value changes
// //   }
// // }

// // class RecommendationSection extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       padding: EdgeInsets.all(16),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(12),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black12,
// //             blurRadius: 8,
// //           ),
// //         ],
// //       ),
// //       child: Row(
// //         children: [
// //           // Icon/Image for Recommendation
// //           // Image.network(
// //           //   'https://yourimageurl.com', // Replace with actual image URL
// //           //   height: 50,
// //           //   width: 50,
// //           // ),
// //           SizedBox(width: 16),

// //           // Text Content
// //           Expanded(
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(
// //                   'คำแนะนำ',
// //                   style: TextStyle(
// //                     fontSize: 18,
// //                     fontWeight: FontWeight.bold,
// //                   ),
// //                 ),
// //                 Text(
// //                   'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut et massa mi.',
// //                   style: TextStyle(fontSize: 14, color: Colors.grey[600]),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
