import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wellwave_frontend/features/article/data/models/article_model.dart';

class ArticleRepository {
  final String apiUrl = "http://localhost:3001/article/search"; 

  Future<List<Article>> fetchArticles() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load articles");
    }
  }
}
