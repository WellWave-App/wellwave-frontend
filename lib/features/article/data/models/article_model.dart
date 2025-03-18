// class Article {
//   final int aid;
//   final String topic;
//   final String body;
//   final int estimatedReadTime;
//   final String? author;
//   final String thumbnailUrl;
//   final int viewCount;
//   final DateTime publishDate;
//   final List<Disease> diseases;

//   Article({
//     required this.aid,
//     required this.topic,
//     required this.body,
//     required this.estimatedReadTime,
//     this.author,
//     required this.thumbnailUrl,
//     required this.viewCount,
//     required this.publishDate,
//     required this.diseases,
//   });

//   factory Article.fromJson(Map<String, dynamic> json) {
//     return Article(
//       aid: json['AID'],
//       topic: json['TOPIC'],
//       body: json['BODY'],
//       estimatedReadTime: json['ESTIMATED_READ_TIME'],
//       author: json['AUTHOR'],
//       thumbnailUrl: json['THUMBNAIL_URL'],
//       viewCount: json['VIEW_COUNT'],
//       publishDate: DateTime.parse(json['PUBLISH_DATE']),
//       diseases: (json['diseases'] as List)
//           .map((disease) => Disease.fromJson(disease))
//           .toList(),
//     );
//   }
// }

// class Disease {
//   final int diseaseId;
//   final String thName;
//   final String engName;

//   Disease({
//     required this.diseaseId,
//     required this.thName,
//     required this.engName,
//   });

//   factory Disease.fromJson(Map<String, dynamic> json) {
//     return Disease(
//       diseaseId: json['DISEASE_ID'],
//       thName: json['TH_NAME'],
//       engName: json['ENG_NAME'],
//     );
//   }
// }

class DiseaseModel {
  final int diseaseId;
  final String thName;
  final String engName;

  DiseaseModel({
    required this.diseaseId,
    required this.thName,
    required this.engName,
  });

  factory DiseaseModel.fromJson(Map<String, dynamic> json) {
    return DiseaseModel(
      diseaseId: json['DISEASE_ID'],
      thName: json['TH_NAME'],
      engName: json['ENG_NAME'],
    );
  }
}

String getThumbnailUrl(String? url) {
  return url ??
      'https://path/to/default-image.jpg'; // ใช้ภาพสำรองหาก url เป็น null
}

class ArticleModel {
  final int aid;
  final String topic;
  final String body;
  final int estimatedReadTime;
  final String? author;
  final String thumbnailUrl;
  final int viewCount;
  final DateTime publishDate;
  final List<DiseaseModel> diseases;

  ArticleModel({
    required this.aid,
    required this.topic,
    required this.body,
    required this.estimatedReadTime,
    this.author,
    required this.thumbnailUrl,
    required this.viewCount,
    required this.publishDate,
    required this.diseases,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      aid: json['AID'] ?? 0,
      topic: json['TOPIC'] ?? '',
      body: json['BODY'],
      estimatedReadTime: json['ESTIMATED_READ_TIME'] ?? 0,
      author: json['AUTHOR'], // อนุญาตให้เป็น null ได้อยู่แล้ว
      thumbnailUrl: json['THUMBNAIL_URL'] ?? '',
      viewCount: json['VIEW_COUNT'],
      publishDate: json['PUBLISH_DATE'] != null
          ? DateTime.parse(json['PUBLISH_DATE'])
          : DateTime.now(),

      // ✅ ป้องกัน null โดยใช้ ?? []
      diseases: (json['diseases'] as List?)
              ?.map((d) => DiseaseModel.fromJson(d))
              .toList() ??
          [],
    );
  }
}
