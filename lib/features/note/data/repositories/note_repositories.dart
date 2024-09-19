import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/note_request_model.dart';
import '../models/note_response_model.dart';

class NoteRequestRepository {
  final String baseUrl;

  NoteRequestRepository({required this.baseUrl});

  // Create new Note request
  Future<bool> createNoteRequest(NoteRequestModel noteRequest) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/notes"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(noteRequest.toJson()),
      );

      if (response.statusCode == 201) {
        // Successfully created
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Error: $e');
      return false;
    }
  }

  // Edit Note request
  Future<bool> editNoteRequest(String noteId, NoteRequestModel noteRequest, String isShowToEmployee) async {
    try {
      final response = await http.put(
        Uri.parse("$baseUrl/notes/$noteId"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(noteRequest.toEditNoteRequestJson(isShowToEmployee)),
      );

      if (response.statusCode == 200) {
        // Successfully edited
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Error: $e');
      return false;
    }
  }

  // Get a list of notes (could be paginated)
  Future<List<NoteResponseModel>> getNoteList() async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/notes"),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body);
        return jsonData.map((note) => NoteResponseModel.fromJson(note)).toList();
      }
      return [];
    } catch (e) {
      debugPrint('Error: $e');
      return [];
    }
  }

  // Get a specific note by ID
  Future<NoteResponseModel?> getNoteById(String noteId) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/notes/$noteId"),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return NoteResponseModel.fromJson(jsonData);
      }
      return null;
    } catch (e) {
      debugPrint('Error: $e');
      return null;
    }
  }
}
