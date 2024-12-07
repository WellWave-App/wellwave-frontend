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
          
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), 
              topRight: Radius.circular(10), 
            ),
            child: Image.network(
              'https://cdn.discordapp.com/attachments/887344508726022164/1288545644532727818/image.png?ex=675527e5&is=6753d665&hm=aace91163696c8dec91a0edd899e35667b70a259c35b3760f3391ecee0485cd8&',
              width: double.infinity,
              height: 86,
              fit: BoxFit.cover,
            ),
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
