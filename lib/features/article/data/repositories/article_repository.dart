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

import '../models/article_bookmark.dart';

class ArticleRepository {
  final String baseUrl = "http://10.0.2.2:3000/";

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
      String url = "${baseUrl}article/search";
      if (diseaseIds != null && diseaseIds.isNotEmpty) {
        url += "?diseaseIds=$diseaseIds";
        print("🔍 Querying with diseaseIds: $diseaseIds");
      } else {
        print("📜 Fetching all articles (no diseaseIds)");
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

  Future<List<BookmarkModel>> fetchBookmarkedArticles(String userId) async {
    final url = "${baseUrl}user-read-history/bookmarks/$userId";
    print("📡 Fetching bookmarked articles from: $url");

    try {
      final response = await http.get(Uri.parse(url));

      // ตรวจสอบสถานะของ Response ก่อน
      if (response.statusCode == 200) {
        // พิมพ์ข้อมูลเพื่อดีบัก
        print("Response body bookmark: ${response.body}");

        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (!jsonResponse.containsKey('data')) {
          throw Exception("API response does not contain 'data'");
        }

        List<dynamic> bookmarkedArticlesJson = jsonResponse['data'] as List;
        return bookmarkedArticlesJson
            .map((json) => BookmarkModel.fromJson(json))
            .toList();
      } else {
        final errorResponse = json.decode(response.body);
        String errorMessage = errorResponse['message'] ?? "Unknown error";
        throw Exception("Failed to load bookmarked articles: $errorMessage");
      }
    } catch (e) {
      // เพิ่มการพิมพ์ข้อมูลเพื่อดีบัก error ที่เกิดขึ้น
      print("Error fetching bookmarked articles: $e");
      throw Exception("Error fetching bookmarked articles: $e");
    }
  }
}
