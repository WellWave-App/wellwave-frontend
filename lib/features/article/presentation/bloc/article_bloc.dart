// article_bloc.dart

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:wellwave_frontend/features/article/data/models/article_bookmark.dart';
import 'package:wellwave_frontend/features/article/presentation/bloc/article_state.dart';
import '../../data/models/article_model.dart';
import '../../data/repositories/article_repository.dart';

part 'article_event.dart';

// class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
//   final ArticleRepository articleRepository;

//   // Constructor
//   ArticleBloc(this.articleRepository, {required ArticleRepository articleRepository}) : super(ArticleInitial()) {
//     on<FetchArticlesEvent>((event, emit) async {
//       emit(ArticleLoading()); // กำลังโหลดข้อมูล

//       try {
//         final articles = await articleRepository.fetchArticles();
//         emit(ArticleLoaded(articles)); // ส่งข้อมูลเมื่อโหลดสำเร็จ
//       } catch (e) {
//         emit(ArticleError("ไม่สามารถโหลดข้อมูลได้: ${e.toString()}"));
//         debugPrint("ไม่สามารถโหลดข้อมูลได้: ${e.toString()}");
//       }
//     });
//   }
// }

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ArticleRepository articleRepository;
  // ✅ Make sure you have a repository for fetching bookmarked articles

  // ✅ Update the constructor to match your repository and logic
  ArticleBloc(this.articleRepository) : super(ArticleInitial()) {
    // Handle FetchArticlesEvent (for regular articles)
    on<FetchArticlesEvent>((event, emit) async {
      emit(ArticleLoading());

      try {
        final articles =
            await articleRepository.fetchArticles(diseaseIds: event.diseaseIds);
        emit(ArticleLoaded(articles));
      } catch (e) {
        emit(ArticleError("ไม่สามารถโหลดข้อมูลได้: ${e.toString()}"));
        debugPrint("ไม่สามารถโหลดข้อมูลได้: ${e.toString()}");
      }
    });

    // Handle FetchArticlesBookmarkEvent (for bookmarked articles)
    on<FetchArticlesBookmarkEvent>((event, emit) async {
      emit(ArticleBookmarkLoading());
      try {
        final articlesBookmark =
            await articleRepository.fetchBookmarkedArticles();
        emit(ArticleBookmarkLoaded(
            articlesBookmark)); // ส่งออก state ที่โหลดแล้ว
      } catch (e) {
        emit(ArticleError("ไม่สามารถโหลดข้อมูลการบันทึก: ${e.toString()}"));
        debugPrint("ไม่สามารถโหลดข้อมูลการบันทึก: ${e.toString()}");
      }
    });

    on<ToggleBookmarkEvent>((event, emit) async {
      try {
        // ก่อนที่จะไปเปลี่ยนสถานะ bookmark ใน repository, ทำการเปลี่ยนแปลงสถานะใน UI ก่อน
        emit(BookmarkUpdated(aid: event.aid, isBookmarked: !event.isBookmark));

        // เรียกใช้ repository เพื่อเปลี่ยนสถานะ Bookmark
        final success =
            await articleRepository.toggleBookmark(event.aid, event.isBookmark);

        if (success) {
          // ถ้าการอัปเดตสำเร็จแล้ว ส่งสถานะการอัปเดต
          emit(
              BookmarkUpdated(aid: event.aid, isBookmarked: !event.isBookmark));
        } else {
          emit(ArticleError("❌ ไม่สามารถเปลี่ยนสถานะ Bookmark ได้"));
        }
      } catch (e) {
        emit(ArticleError(
            "❌ เกิดข้อผิดพลาดในการอัปเดต Bookmark: ${e.toString()}"));
      }
    });

    on<FetchRecommendArticleEvent>((event, emit) async {
      emit(ArticleRecommendLoading()); // แสดงสถานะกำลังโหลด

      try {
        // เรียกใช้ fetchCommentArticle จาก repository
        final articles = await articleRepository.fetchRecommendArticle();
        emit(ArticleRecommendLoaded(
            articles)); // ส่งข้อมูลบทความที่ดึงมาในสถานะ ArticleLoaded
      } catch (e) {
        emit(ArticleError("ไม่สามารถดึงข้อมูลบทความ: ${e.toString()}"));
        print(e.toString());
      }
    });
  }
}
