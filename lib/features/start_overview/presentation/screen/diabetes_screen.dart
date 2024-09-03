import 'package:flutter/material.dart';
import 'package:wellwave_frontend/features/home/presentation/screen/splash_screen.dart';

class MitaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to the home screen
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => SplashScreen()),
              (Route<dynamic> route) => false,
            );
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Placeholder for the image
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                color: Colors.grey[300], // Placeholder color
                child: Center(
                  child: Icon(
                    Icons.image,
                    size: 100,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          // Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'โรคเมตาบอลิซินโดรม', // Title in Thai
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          // Description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut et massa mi. Aliquam in hendrerit urna. Pellentesque sit amet sapien fringilla, mattis ligula consectetur, ultrices mauris.',
              textAlign: TextAlign.center,
            ),
          ),
          // Pagination indicator
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.circle, size: 8, color: Colors.grey),
                SizedBox(width: 4),
                Icon(Icons.circle, size: 8, color: Colors.black),
                SizedBox(width: 4),
                Icon(Icons.circle, size: 8, color: Colors.grey),
              ],
            ),
          ),
          // Action button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Add your navigation or action here
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                backgroundColor: Colors.grey[300], // Placeholder for button color
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'เข้าสู่แอพ', // Button text in Thai
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}