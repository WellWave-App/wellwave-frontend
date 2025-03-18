// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:wellwave_frontend/features/article/data/models/article_model.dart';

// class ArticleRepository {
//   final String apiUrl = "http://10.0.2.2:3000/article/search";

//   Future<List<Article>> fetchArticles() async {
//     final response = await http.get(Uri.parse(apiUrl));

//     if (response.statusCode == 200) {
//       List<dynamic> data = json.decode(response.body);
//       return data.map((json) => Article.fromJson(json)).toList();
//     } else {
//       throw Exception("Failed to load articles");
//     }
//   }
// }
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wellwave_frontend/features/article/data/models/article_model.dart';

class ArticleRepository {
  final String apiUrl = "http://10.0.2.2:3000/article/search";

  // Future<List<ArticleModel>> fetchArticles() async {
  //   final response = await http.get(Uri.parse(apiUrl));

  //   if (response.statusCode == 200) {
  //     print("Raw Response: ${response.body}"); // 🔍 Debug JSON

  //     final Map<String, dynamic> jsonResponse = json.decode(response.body);

  //     // ✅ เช็คให้ถูกต้องว่า API ส่ง `data` ไม่ใช่ `articles`
  //     if (!jsonResponse.containsKey('data')) {
  //       throw Exception("API response does not contain 'data'");
  //     }

  //     List<dynamic> articlesJson = jsonResponse['data'];

  //     return articlesJson.map((json) => ArticleModel.fromJson(json)).toList();
  //   } else {
  //     throw Exception("Failed to load articles");
  //   }
  // }
  Future<List<ArticleModel>> fetchArticles({String? diseaseIds}) async {
    print("🚀 fetchArticles() CALLED with diseaseIds: $diseaseIds");

    try {
      String url = apiUrl;
      if (diseaseIds != null) {
        url += '?diseaseIds=$diseaseIds';
        print("🔍 hihihi diseaseIds received: $diseaseIds");
      }

      print(url);
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        print("Raw Response: ${response.body}"); // 🔍 Debug JSON

        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (!jsonResponse.containsKey('data')) {
          throw Exception("API response does not contain 'data'");
        }

        List<dynamic> articlesJson = jsonResponse['data'];
        return articlesJson.map((json) => ArticleModel.fromJson(json)).toList();
      } else {
        // ลองอ่าน error message จาก API ถ้ามี
        final errorResponse = json.decode(response.body);
        String errorMessage =
            errorResponse['message'] ?? "Unknown error occurred";

        throw Exception("Failed to load articles: $errorMessage");
      }
    } catch (e) {
      throw Exception("Error fetching articles: $e");
    }
  }
}
