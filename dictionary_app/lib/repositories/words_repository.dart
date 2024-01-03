import 'dart:convert';

import 'package:dictionary_app/entities/word.dart';
import 'package:http/http.dart' as http;

class WordsRepository {
  WordsRepository();

  Future<List<Word>> getWord(String word) async {
    final url =
        Uri.parse('https://api.dictionaryapi.dev/api/v2/entries/en/$word');

    try {
      final response = await http.get(url);
      List jsonResponse = json.decode(response.body);

      return jsonResponse.map((item) => Word.fromJson(item)).toList();
    } catch (e) {
      throw Exception('Failed to load word, error $e');
    }
  }
}
