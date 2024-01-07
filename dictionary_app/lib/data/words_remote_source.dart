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

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}
