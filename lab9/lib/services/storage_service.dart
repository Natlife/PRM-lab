import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import '../models/book_model.dart';

class StorageService {
  Future<List<BookModel>> loadBooksFromAssets() async {
    final String response = await rootBundle.loadString('assets/data/books.json');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => BookModel.fromJson(json)).toList();
  }

  Future<File> get _localFile async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/local_books.json');
  }

  Future<List<BookModel>> loadBooksFromStorage() async {
    try {
      final file = await _localFile;
      if (await file.exists()) {
        final contents = await file.readAsString();
        final List<dynamic> data = json.decode(contents);
        return data.map((json) => BookModel.fromJson(json)).toList();
      } else {
        final assetsBooks = await loadBooksFromAssets();
        await saveBooksToStorage(assetsBooks);
        return assetsBooks;
      }
    } catch (_) {
      return [];
    }
  }

  Future<void> saveBooksToStorage(List<BookModel> books) async {
    try {
      final file = await _localFile;
      final String jsonString = json.encode(books.map((b) => b.toJson()).toList());
      await file.writeAsString(jsonString);
    } catch (_) {}
  }
}
