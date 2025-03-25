import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/features/article/presentation/bloc/article_bloc.dart';
import 'package:wellwave_frontend/features/article/presentation/bloc/article_state.dart';

import '../../data/models/article_model.dart';

class ArticleDetailScreen extends StatelessWidget {
  const ArticleDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = GoRouterState.of(context);
    final article = state.extra as ArticleModel?;
    final aid = article?.aid is int ? article?.aid as int : 0;
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
              icon: Container(
                padding: EdgeInsets.all(10.0), // ระยะห่างระหว่างไอคอนและกรอบ
                decoration: BoxDecoration(
                  color: Colors.white, // สีของกรอบ
                  shape: BoxShape.circle, // ให้กรอบเป็นวงกลม
                ),
                width: 36, // กำหนดขนาดของกรอบวงกลม
                child: Center(
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black, // สีของไอคอน
                  ),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          BlocBuilder<ArticleBloc, ArticleState>(
            builder: (context, state) {
              bool isBookmarked = false;

              // ตรวจสอบสถานะของ Bookmark จาก state ที่ได้รับ
              if (state is BookmarkUpdated && state.aid == aid) {
                isBookmarked = state.isBookmarked;
              }

              return Positioned(
                top: 40,
                right: 70,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 2),
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(
                      isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      // ส่ง event เพื่อเปลี่ยนสถานะ bookmark
                      context.read<ArticleBloc>().add(
                            ToggleBookmarkEvent(
                              aid: aid,
                              isBookmark: isBookmarked, // สลับสถานะของ Bookmark
                            ),
                          );
                    },
                  ),
                ),
              );
            },
          ),
          Positioned(
            top: 40,
            right: 16,
            child: IconButton(
              icon: Container(
                padding: EdgeInsets.all(6.0), // ระยะห่างระหว่างไอคอนและกรอบ
                decoration: BoxDecoration(
                  color: Colors.white, // สีของกรอบ
                  shape: BoxShape.circle, // ให้กรอบเป็นวงกลม
                ),
                width: 40, // กำหนดขนาดของกรอบวงกลม
                child: Icon(
                  Icons.share,
                  color: Colors.black, // สีของไอคอน
                ),
              ),
              onPressed: () {
                String articleLink =
                    "http://10.0.2.2:3000/$aid"; // แก้ไขลิงก์ตามต้องการ
                Share.share("อ่านบทความนี้ได้ที่: $articleLink");
              },
            ),
          ),
        ],
      ),
    );
  }
}
