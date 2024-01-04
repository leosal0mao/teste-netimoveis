import 'package:dictionary_app/services/shared_preferences_cached_data.dart';
import 'package:http/http.dart' as http;

class WordsRemoteSource {
  final MySharedPreferences? mySharedPreferences;

  WordsRemoteSource(this.mySharedPreferences);

  Future<dynamic> fetchData(String word) async {
    try {
      final url =
          Uri.parse('https://api.dictionaryapi.dev/api/v2/entries/en/$word');

      final response = await http.get(url);

      if (response.statusCode != 200) {
        throw Exception("Failed to load word");
      } else {
        final isSaved = await mySharedPreferences!
            .saveDataWithExpiration(response.body, const Duration(days: 15));
        if (isSaved) {
          return response.body;
        } else {
          throw Exception("Failed to save data to shared preferences");
        }
      }
    } catch (e) {
      throw Exception(e);
    }
  }
  //  Future<dynamic> fetchData(String word) async {
  //   final url =
  //       Uri.parse('https://api.dictionaryapi.dev/api/v2/entries/en/$word');

  //   try {
  //     final response = await http.get(url);
  //     List<dynamic> jsonResponse = json.decode(response.body);
  //     List<Word> words = Word.fromJsonList(jsonResponse);

  //     return words;
  //   } on Exception catch (e) {
  //     throw Exception('Failed to load word, error $e');
  //   }
  // }
}
