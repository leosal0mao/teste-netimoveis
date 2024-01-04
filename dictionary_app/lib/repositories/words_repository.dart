import 'dart:convert';

import 'package:dictionary_app/data/words_remote_source.dart';
import 'package:dictionary_app/services/shared_preferences_cached_data.dart';

import '../entities/word.dart';

class WordsRepository {
  final WordsRemoteSource remoteSource;
  final MySharedPreferences sharedPreferences;

  WordsRepository({
    required this.remoteSource,
    required this.sharedPreferences,
  });

  Future<dynamic> getWord(String word) async {
    try {
      final String? jsonData = await sharedPreferences.getDataIfNotExpired();
      if (jsonData != null) {
        final List<dynamic> jsonList = jsonDecode(jsonData);
        final wordData = jsonList.firstWhere(
            (element) => element['word'] == word,
            orElse: () => null);

        if (wordData != null) {
          return Word.fromJson(wordData);
        } else {
          await remoteSource.fetchData(word);
          return getWord(word);
        }
      } else {
        await remoteSource.fetchData(word);
        return getWord(word);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  // Function to refresh data from the API and update the cache
  Future<dynamic> refreshData(String word) async {
    await remoteSource.fetchData(word);
    return getWord(word);
  }
}
