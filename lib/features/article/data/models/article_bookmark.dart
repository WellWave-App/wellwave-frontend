import 'package:wellwave_frontend/features/article/data/models/article_model.dart';

class BookmarkModel {
  final int uid;
  final int aid;
  final bool isRead;
  final bool isBookmark;
  final int rating;
  final String firstReadDate;
  final String lastedReadDate;
  final SimpleArticleModel article;

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
      article: SimpleArticleModel.fromJson(json['article'] ?? {}),
    );
  }
}

// A simplified article model for use in bookmarks
class SimpleArticleModel {
  final int aid;
  final String topic;
  final int estimatedReadTime;
  final String thumbnailUrl;

  SimpleArticleModel({
    required this.aid,
    required this.topic,
    required this.estimatedReadTime,
    required this.thumbnailUrl,
  });

  factory SimpleArticleModel.fromJson(Map<String, dynamic> json) {
    return SimpleArticleModel(
      aid: json['AID'] ?? 0,
      topic: json['TOPIC'] ?? '',
      estimatedReadTime: json['ESTIMATED_READ_TIME'] ?? 0,
      thumbnailUrl: json['THUMBNAIL_URL'] ?? '',
    );
  }
}
