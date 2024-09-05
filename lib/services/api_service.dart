import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:bookmarks_app/models/book_list.dart';
import 'package:bookmarks_app/models/book.dart';

class ApiService {
  static const String _baseUrl = 'https://api.nytimes.com/svc/books/v3';
  static String get _apiKey => dotenv.env['API_KEY'] ?? '';

  static Future<List<BookList>> getPopularLists() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/lists/names.json?api-key=$_apiKey'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['results'] as List)
          .map((item) => BookList.fromJson(item))
          .toList();
    }
    throw Exception('Failed to load lists');
  }

  static Future<List<Book>> getBooksForList(String listNameEncoded) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/lists/current/$listNameEncoded.json?api-key=$_apiKey'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['results']['books'] as List)
          .map((item) => Book.fromJson(item))
          .toList();
    }
    throw Exception('Failed to load books');
  }
}