import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_pages.dart';
import 'package:wellwave_frontend/features/article/presentation/bloc/article_state.dart';
import '../bloc/article_bloc.dart';

class RecommendationCard extends StatelessWidget {
  final String title;
  final int readingTime;
  final String imageUrl;
  final dynamic article;
  final int aid; // เพิ่ม aid ของบทความ

  RecommendationCard({
    required this.title,
    required this.readingTime,
    required this.imageUrl,
    required this.article,
    required this.aid,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.goNamed(
          AppPages.articleDetailName, // ใช้ชื่อ route ที่กำหนดไว้
          extra: article, // ส่งข้อมูลบทความไปด้วย
        );
      },
      child: Card(
        color: AppColors.whiteColor,
        margin: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5,
        child: Container(
          height: 200,
          color: AppColors.yellowColor,
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
                      "http://10.0.2.2:3000${article!.thumbnailUrl}",
                      width: double.infinity,
                      height: 86,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: double.infinity,
                          height: 86,
                          color: Colors.pink,
                          child: Center(
                            child: Icon(
                              Icons.broken_image,
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // BlocBuilder<ArticleBloc, ArticleState>(
                  //   builder: (context, state) {
                  //     bool isBookmarked = false;

                  //     // ตรวจสอบสถานะของ Bookmark จาก state ที่ได้รับ
                  //     if (state is ArticleBookmarkLoaded) {
                  //       final bookmarkedArticles = state.articlesBookmark;
                  //       isBookmarked = bookmarkedArticles.any((article) => article.aid == aid);
                  //     }

                  //     return Positioned(
                  //       top: 5,
                  //       right: 5,
                  //       child: Container(
                  //         width: 38,
                  //         decoration: BoxDecoration(
                  //           color: Colors.white.withOpacity(0.8),
                  //           shape: BoxShape.circle,
                  //         ),
                  //         child: IconButton(
                  //           icon: Icon(
                  //             isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  //             color: Colors.black,
                  //           ),
                  //           onPressed: () {
                  //             context.read<ArticleBloc>().add(
                  //               ToggleBookmarkEvent(
                  //                 aid: aid,
                  //                 isBookmark: !isBookmarked, // สลับสถานะของ Bookmark
                  //               ),
                  //             );
                  //           },
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              height: 1.0,
                            ),
                        maxLines: 2,
                        overflow:
                            TextOverflow.clip, // เปลี่ยนจาก ellipsis เป็น clip
                      ),
                      SizedBox(height: 2),
                      Text(
                        '$readingTime min read',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.darkGrayColor, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
