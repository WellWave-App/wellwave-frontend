// import 'package:wellwave_frontend/features/article/data/models/article_model.dart';

// class BookmarkModel {
//   final int uid;
//   final int aid;
//   final bool isRead;
//   final bool isBookmark;
//   final int rating;
//   final String firstReadDate;
//   final String lastedReadDate;
//   final SimpleArticleModel article;

//   BookmarkModel({
//     required this.uid,
//     required this.aid,
//     required this.isRead,
//     required this.isBookmark,
//     required this.rating,
//     required this.firstReadDate,
//     required this.lastedReadDate,
//     required this.article,
//   });

//   factory BookmarkModel.fromJson(Map<String, dynamic> json) {
//     return BookmarkModel(
//       uid: json['UID'] ?? 0,
//       aid: json['AID'] ?? 0,
//       isRead: json['IS_READ'] ?? false,
//       isBookmark: json['IS_BOOKMARK'] ?? false,
//       rating: json['RATING'] ?? 0,
//       firstReadDate: json['FIRST_READ_DATE'] ?? '',
//       lastedReadDate: json['LASTED_READ_DATE'] ?? '',
//       article: SimpleArticleModel.fromJson(json['article'] ?? {}),
//     );
//   }
// }

// // A simplified article model for use in bookmarks
// // class SimpleArticleModel {
// //   final int aid;
// //   final String topic;
// //   final int estimatedReadTime;
// //   final String thumbnailUrl;

// //   SimpleArticleModel({
// //     required this.aid,
// //     required this.topic,
// //     required this.estimatedReadTime,
// //     required this.thumbnailUrl,
// //   });

// //   factory SimpleArticleModel.fromJson(Map<String, dynamic> json) {
// //     return SimpleArticleModel(
// //       aid: json['AID'] ?? 0,
// //       topic: json['TOPIC'] ?? '',
// //       estimatedReadTime: json['ESTIMATED_READ_TIME'] ?? 0,
// //       thumbnailUrl: json['THUMBNAIL_URL'] ?? '',
// //     );
// //   }

// //   // Convert SimpleArticleModel to ArticleModel
// //   ArticleModel toArticleModel() {
// //   return ArticleModel(
// //     aid: aid,
// //     topic: topic,
// //     body: '', // Placeholder for the article body
// //     estimatedReadTime: estimatedReadTime ?? 0,
// //     author: null,
// //     thumbnailUrl: thumbnailUrl,
// //     viewCount: this.viewCount ?? 0, // ✅ Ensure it is defined
// //     publishDate: DateTime.now(), // Default to current date if missing
// //     diseases: [], // Default to an empty list
// //   );
// // }
// class SimpleArticleModel {
//   final int aid;
//   final String topic;
//   final int estimatedReadTime;
//   final String thumbnailUrl;

//   SimpleArticleModel({
//     required this.aid,
//     required this.topic,
//     required this.estimatedReadTime,
//     required this.thumbnailUrl,
//   });

//   factory SimpleArticleModel.fromJson(Map<String, dynamic> json) {
//     return SimpleArticleModel(
//       aid: json['AID'] ?? 0,
//       topic: json['TOPIC'] ?? '',
//       estimatedReadTime: json['ESTIMATED_READ_TIME'] ?? 0,
//       thumbnailUrl: json['THUMBNAIL_URL'] ?? '',
//     );
//   }

//   // Convert SimpleArticleModel to ArticleModel
//   ArticleModel toArticleModel({
//     required int viewCount,
//     required DateTime publishDate,
//     required List<DiseaseModel> diseases,
//     String? author,
//     String body = '',
//   }) {
//     return ArticleModel(
//       aid: aid,
//       topic: topic,
//       body: body,
//       estimatedReadTime: estimatedReadTime,
//       author: author,
//       thumbnailUrl: thumbnailUrl,
//       viewCount: viewCount,
//       publishDate: publishDate,
//       diseases: diseases,
//     );
//   }
// }
import 'package:wellwave_frontend/features/article/data/models/article_model.dart';

class BookmarkModel {
  final int uid;
  final int aid;
  final bool isRead;
  final bool isBookmark;
  final int rating;
  final String firstReadDate;
  final String lastedReadDate;
  final ArticleModel article; // เปลี่ยนเป็น ArticleModel

  BookmarkModel({
    required this.uid,
    required this.aid,
    required this.isRead,
    required this.isBookmark,
    required this.rating,
    required this.firstReadDate,
    required this.lastedReadDate,
    required this.article,
  });

  factory BookmarkModel.fromJson(Map<String, dynamic> json) {
    return BookmarkModel(
      uid: json['UID'] ?? 0,
      aid: json['AID'] ?? 0,
      isRead: json['IS_READ'] ?? false,
      isBookmark: json['IS_BOOKMARK'] ?? false,
      rating: json['RATING'] ?? 0,
      firstReadDate: json['FIRST_READ_DATE'] ?? '',
      lastedReadDate: json['LASTED_READ_DATE'] ?? '',
      article: ArticleModel.fromJson(
          json['article'] ?? {}), // ใช้ ArticleModel โดยตรง
    );
  }
}
