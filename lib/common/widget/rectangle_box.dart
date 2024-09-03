import 'package:flutter/material.dart';

class Rectangle_box extends StatelessWidget {
  final String title;

  const Rectangle_box({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the screen width and divide it by 2
    double containerWidth = MediaQuery.of(context).size.width / 2 - 32;

    return Container(
      width:
          containerWidth, // Set the container's width to half the screen width
      height: 128,
      padding: const EdgeInsets.all(12.0), // Padding inside the box
      decoration: BoxDecoration(
        color: Colors.grey[300], // Background color of the box
        borderRadius: BorderRadius.circular(12.0), // Rounded corners
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            MainAxisAlignment.end, // Aligns text to the start (left)
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyMedium, // Adjust text style as needed
          ),
          // Add more widgets here if needed
        ],
      ),
    );
  }
}
