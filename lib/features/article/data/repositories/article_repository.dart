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
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:wellwave_frontend/features/article/data/models/article_model.dart';

import '../models/article_bookmark.dart';

class ArticleRepository {
  final String baseUrl = "http://ce67-16.cloud.ce.kmitl.ac.th/api/v1";
  final _secureStorage = const FlutterSecureStorage();

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
  Future<List<ArticleModel>> fetchRecommendArticle() async {
    final uid = await _secureStorage.read(key: 'user_uid');

    final url =
        Uri.parse('${baseUrl}get-rec/articles?uid=$uid&includeRead=true');

    try {
      // ส่งคำขอ GET ไปยัง API
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // แปลง JSON response เป็น List<ArticleModel>
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        List<dynamic> articlesJson = jsonResponse['data'];
        return articlesJson.map((json) => ArticleModel.fromJson(json)).toList();
      } else {
        // หากได้รับรหัสสถานะที่ไม่ใช่ 200, โยนข้อผิดพลาด
        throw Exception('Failed to load articles: ${response.body}');
      }
    } catch (e) {
      // จัดการข้อผิดพลาดที่เกิดจากเครือข่ายหรือการแปลงข้อมูล
      throw Exception('Error fetching articles: $e');
    }
  }

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

  Future<List<BookmarkModel>> fetchBookmarkedArticles() async {
    final uid = await _secureStorage.read(key: 'user_uid');

    final url = "${baseUrl}user-read-history/bookmarks/$uid";
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

  Future<bool> toggleBookmark(int aid, bool isBookmark) async {
    final uidString = await _secureStorage.read(key: 'user_uid');
    final uid =
        int.tryParse(uidString ?? ''); // Convert to int if it's a valid string

    if (uid == null) {
      throw Exception("Invalid UID");
    }

    final url =
        "${baseUrl}user-read-history/updateBookmark"; // Your original API URL
    print("📡bookmarked articles from: $url");

    try {
      final response = await http.patch(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "UID": uid,
          "AID": aid,
          "IS_BOOKMARK": !isBookmark, // Toggle the bookmark status
        }),
      );
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print('success update');
        return true; // Successfully created or updated bookmark
      } else if (response.statusCode == 409) {
        // If conflict, maybe you need to update or take another action
        print("Conflict occurred, attempting to handle update...");

        // You can optionally add more logic here to reattempt with different params if needed
        return true; // Assume it's handled properly
      } else {
        throw Exception("Failed to update bookmark");
      }
    } catch (e) {
      print("Error occurred: $e");
      throw Exception("Failed to toggle bookmark");
    }
  }

  Future<List<ArticleModel>> searchArticles(String query) async {
    try {
      final response =
          await http.get(Uri.parse('${baseUrl}/article/search?search=$query'));

      print('search :${response.statusCode}');
      print('search :${response.body}');

      if (response.statusCode == 200) {
        // แปลง JSON ที่ได้รับจาก API
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        // ตรวจสอบว่า 'data' มีอยู่ใน JSON หรือไม่
        if (!jsonResponse.containsKey('data')) {
          throw Exception("API response does not contain 'data'");
        }

        // ดึงข้อมูลจากคีย์ 'data' ซึ่งเป็น List ของ articles
        List<dynamic> data = jsonResponse['data'];

        // แปลงข้อมูลใน 'data' ให้เป็น List ของ ArticleModel
        return data.map((e) => ArticleModel.fromJson(e)).toList();
      } else {
        throw Exception('ไม่สามารถดึงข้อมูลได้');
      }
    } catch (e) {
      throw Exception('เกิดข้อผิดพลาดในการค้นหา: $e');
    }
  }
}
