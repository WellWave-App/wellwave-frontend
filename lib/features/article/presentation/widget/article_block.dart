import 'dart:convert';
import 'package:flutter/material.dart';

String jsonString = '''{
  "articles": [
    {
      "title": "บทความที่ 1: วิธีการเรียนรู้ Flutter",
      "readingTime": "5 นาที",
      "imageUrl": "https://via.placeholder.com/150"
    },
    {
      "title": "บทความที่ 2: เรียนรู้ Flutter Widgets",
      "readingTime": "10 นาที",
      "imageUrl": "https://via.placeholder.com/150"
    },
    {
      "title": "บทความที่ 3: เรียนรู้การจัดการสถานะใน Flutter",
      "readingTime": "8 นาที",
      "imageUrl": "https://via.placeholder.com/150"
    },
     {
      "title": "บทความที่ 3: เรียนรู้การจัดการสถานะใน Flutter",
      "readingTime": "8 นาที",
      "imageUrl": "https://via.placeholder.com/150"
    },
     {
      "title": "บทความที่ 3: เรียนรู้การจัดการสถานะใน Flutter",
      "readingTime": "8 นาที",
      "imageUrl": "https://via.placeholder.com/150"
    }
  ]
}''';

class RecommendationCard extends StatelessWidget {
  final String title;
  final String readingTime;
  final String imageUrl;

  RecommendationCard({
    required this.title,
    required this.readingTime,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: Image.network(
                  'https://i0.wp.com/www.michigandaily.com/wp-content/uploads/2021/03/0-1.jpg?fit=1200%2C960&ssl=1',
                  width: double.infinity,
                  height: 86,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: Container(
                  width: 38,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.bookmark_border,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      print("Bookmark pressed!");
                    },
                  ),
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'title',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 5),
                Text(
                  '7 นาที',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
