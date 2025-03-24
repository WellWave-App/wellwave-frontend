// import 'package:flutter/material.dart';

// class CustomProgressBarWithIcon extends StatelessWidget {
//   const CustomProgressBarWithIcon({Key? key}) : super(key: key);

//   Color _getProgressColor(double progress) {
//     if (progress <= 0.3) {
//       return Colors.red;
//     } else if (progress <= 0.6) {
//       return Colors.yellow;
//     } else {
//       return Colors.green;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     double progressBarWidth = MediaQuery.of(context).size.width - 40;

//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
//       child: Stack(
//         children: [
//           Container(
//             color: Colors.lightGreen,
//             height: 8.0,
//             width: 5,
//             width: progressBarWidth,
//             child: LinearProgressIndicator(
//               value: state.progress,
//               minHeight: 8.0,
//               backgroundColor: Colors.black12,
//               valueColor: AlwaysStoppedAnimation<Color>(
//                 _getProgressColor(state.progress),
//               ),
//             ),
//           ),
//           Positioned(
//             left: state.progress * (progressBarWidth - 24),
//             top: -16,
//             child: Icon(
//               Icons.star,
//               color: Colors.amber,
//               size: 32,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
