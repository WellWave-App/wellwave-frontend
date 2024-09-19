import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/note_request_model.dart';
import '../models/note_response_model.dart';

class NoteRepository {
  final String baseUrl;

  NoteRepository({
    required this.baseUrl,
  }) ;

  // Create new note request
  Future<StatusCode> createNewNoteRequest(NoteRequestModel noteRequest) async {
    try {
      // final accessToken = await _localRepository.getToken();
      // if (accessToken == null) {
      //   throw Exception('There is no token.');
      // }
      final response = await http.post(
        Uri.parse("$baseUrl/noteRequest"), // Define the correct API path
        headers: {
          // "Authorization": "Bearer $accessToken",
          'Content-Type': 'application/json',
        },
        body: jsonEncode(noteRequest.toJson()),
      );
      debugPrint('Response body: ${response.body}');
      if (response.statusCode == 201) {
        return StatusCode.code201;
      } else if (response.statusCode == 400) {
        debugPrint("Bad request");
        return StatusCode.code400;
      } else {
        debugPrint("Request failed");
        return StatusCode.code404;
      }
    } catch (e) {
      debugPrint(e.toString());
      return StatusCode.code404;
    }
  }

  // Edit note request
  Future<StatusCode> editNoteRequest(
    String noteRequestId,
    NoteRequestModel noteRequest,
  ) async {
    try {
      final accessToken = await _localRepository.getToken();
      if (accessToken == null) {
        throw Exception('There is no token.');
      }
      final response = await http.put(
        Uri.parse("$baseUrl/noteRequest/$noteRequestId"), // Define the correct API path
        headers: {
          "Authorization": "Bearer $accessToken",
          'Content-Type': 'application/json',
        },
        body: jsonEncode(noteRequest.toJson()),
      );
      debugPrint('Response body: ${response.body}');
      if (response.statusCode == 200) {
        return StatusCode.code200;
      } else {
        return StatusCode.code404;
      }
    } catch (e) {
      debugPrint(e.toString());
      return StatusCode.code404;
    }
  }

  // Get note history
  Future<List<NoteResponseModel>> getNoteHistory() async {
    try {
      final accessToken = await _localRepository.getToken();
      if (accessToken == null) {
        throw Exception('There is no token.');
      }
      final response = await http.get(
        Uri.parse("$baseUrl/noteHistory"), // Define the correct API path
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        final List<NoteResponseModel> noteHistory =
            jsonData.map((json) => NoteResponseModel.fromMap(json)).toList();
        return noteHistory;
      } else {
        debugPrint(
            'Failed to get data, status code: ${response.statusCode}, ${response.body}');
        return [];
      }
    } catch (e) {
      debugPrint('Error during network request: $e');
      throw Exception('Error during network request: $e');
    }
  }

  // Get specific note by ID
  Future<NoteResponseModel?> getNoteById(String noteId) async {
    try {
      final accessToken = await _localRepository.getToken();
      if (accessToken == null) {
        throw Exception('There is no token.');
      }
      final response = await http.get(
        Uri.parse("$baseUrl/note/$noteId"), // Define the correct API path
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return NoteResponseModel.fromMap(jsonData);
      } else {
        debugPrint(
            'Failed to get data, status code: ${response.statusCode}, ${response.body}');
        return null;
      }
    } catch (e) {
      debugPrint('Error during network request: $e');
      return null;
    }
  }
}
