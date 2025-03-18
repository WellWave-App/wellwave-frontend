import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_pages.dart';

class RecommendationCard extends StatelessWidget {
  final String title;
  final int readingTime;
  final String imageUrl;
  final dynamic article; // เพิ่มตัวแปร article

  RecommendationCard({
    required this.title,
    required this.readingTime,
    required this.imageUrl,
    required this.article, // รับข้อมูลบทความ
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.goNamed(
          AppPages.articleDetailName, // 🔹 ใช้ชื่อ route ที่กำหนดไว้
          extra: article, // 🔹 ส่งข้อมูลบทความไปด้วย
        );
      },
      child: Card(
        color: AppColors.whiteColor,
        margin: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: Image.network(
                    "http://10.0.2.2:3000${article!.thumbnailUrl}", // ใช้ imageUrl ที่ได้รับ
                    width: double.infinity,
                    height: 86,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // ถ้าโหลดภาพไม่สำเร็จ จะแสดง Container สีชมพู
                      return Container(
                        width: double.infinity,
                        height: 86,
                        color: Colors.pink, // สีชมพู
                        child: Center(
                          child: Icon(
                            Icons.broken_image,
                            color: Colors.white, // ไอคอนสีขาว
                          ),
                        ),
                      );
                    },
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          height: 1.0, // ลดระยะห่างระหว่างบรรทัด
                        ),
                    maxLines: 2, // แสดงข้อความได้แค่ 2 บรรทัด
                    overflow:
                        TextOverflow.ellipsis, // ถ้าข้อความยาวเกินจะตัดทิ้งไป
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    '$readingTime min read',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.darkGrayColor, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
