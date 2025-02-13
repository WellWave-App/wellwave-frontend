class Article {
  final int aid;
  final String topic;
  final String body;
  final int estimatedReadTime;
  final String? author;
  final String thumbnailUrl;
  final int viewCount;
  final DateTime publishDate;
  final List<Disease> diseases;

  Article({
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

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      aid: json['AID'],
      topic: json['TOPIC'],
      body: json['BODY'],
      estimatedReadTime: json['ESTIMATED_READ_TIME'],
      author: json['AUTHOR'],
      thumbnailUrl: json['THUMBNAIL_URL'],
      viewCount: json['VIEW_COUNT'],
      publishDate: DateTime.parse(json['PUBLISH_DATE']),
      diseases: (json['diseases'] as List)
          .map((disease) => Disease.fromJson(disease))
          .toList(),
    );
  }
}

class Disease {
  final int diseaseId;
  final String thName;
  final String engName;

  Disease({
    required this.diseaseId,
    required this.thName,
    required this.engName,
  });

  factory Disease.fromJson(Map<String, dynamic> json) {
    return Disease(
      diseaseId: json['DISEASE_ID'],
      thName: json['TH_NAME'],
      engName: json['ENG_NAME'],
    );
  }
}
