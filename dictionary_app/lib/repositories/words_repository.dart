import 'dart:convert';

import 'package:dictionary_app/data/words_remote_source.dart';
import 'package:dictionary_app/entities/word_not_found.dart';
import 'package:dictionary_app/services/shared_preferences_cached_data.dart';
import 'package:http/http.dart';

import '../entities/word.dart';
import '../services/database_helper.dart';

class WordsRepository {
  final WordsRemoteSource remoteSource;
  final MySharedPreferences sharedPreferences;

  WordsRepository({
    required this.remoteSource,
    required this.sharedPreferences,
  });

  Future<dynamic> getWord(String word) async {
    try {
      final Response jsonData = await remoteSource.fetchData(word);
      final dynamic jsonList = jsonDecode(jsonData.body);

      if (jsonData.statusCode == 404) {
        return WordNotFound.fromJson(jsonData.body);
      } else {
        final wordData = jsonList.firstWhere(
            (element) => element['word'] == word,
            orElse: () => null);

        return Word.fromJson(wordData);
      }
    } catch (e) {
      throw Exception('Error in method getWord $e');
    }
  }

  // Function to refresh data from the API and update the cache
  Future<dynamic> refreshData(String word) async {
    await remoteSource.fetchData(word);
    return getWord(word);
  }

  Future<List<Map<String, dynamic>>> loadWordsFromDatabase() async {
    try {
      final db = await DatabaseHelper.instance.database;
      List<Map<String, dynamic>> wordsList = await db.query('words');

      return wordsList;
    } catch (e) {
      throw Exception('error: $e');
    }
  }
}
