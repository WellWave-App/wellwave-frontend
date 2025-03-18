import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';

import '../../data/models/article_model.dart';

class ArticleDetailScreen extends StatelessWidget {
  const ArticleDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = GoRouterState.of(context);
    final article = state.extra as ArticleModel?;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          article?.thumbnailUrl.isNotEmpty == true
              ? Image.network(
                  "http://10.0.2.2:3000${article!.thumbnailUrl}",
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: 250,
                      color: AppColors
                          .blueGrayColor, // สีชมพูเมื่อไม่สามารถโหลดภาพได้
                      child: Center(
                        child: Icon(
                          Icons.error, // ไอคอนแสดงข้อผิดพลาด
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                )
              : const SizedBox.shrink(),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 230),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: article == null
                  ? const Center(child: Text("ไม่พบข้อมูลบทความ"))
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16),
                        Text(
                          article.topic,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.menu_book_rounded,
                                size: 20, color: Colors.grey),
                            SizedBox(width: 4),
                            Text(
                              'readingTime',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            article.body,
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
          Positioned(
            top: 40,
            left: 8,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Positioned(
            top: 40,
            right: 48,
            child: IconButton(
              icon: Icon(Icons.bookmark_border, color: Colors.white),
              onPressed: () {},
            ),
          ),
          Positioned(
            top: 40,
            right: 16,
            child: IconButton(
              icon: Icon(Icons.share, color: Colors.white),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
