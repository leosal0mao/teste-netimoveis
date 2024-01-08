import 'dart:convert';

import 'package:dictionary_app/providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyLocalStorage {
  SharedPreferences prefs = getIt.get<SharedPreferences>();
  MyLocalStorage({required this.prefs});

  void saveData(String key, String value) async {
    String? word = await getData(key);

    if (word == null) {
      await prefs.setString(key, value);
    }
  }

  Future<String?> getData(String key) async {
    final String? item = prefs.getString(key);
    // print('After await getData: $item');
    return item;
  }

  Future<List<Map<String, dynamic>>> getAllLocalData() async {
    var keys = prefs.getKeys();
    List<Map<String, dynamic>> savedWord = [];

    for (var key in keys) {
      String? value = await getData(key);
      if (value != null) {
        try {
          List<dynamic> valuesList = jsonDecode(value);
          for (var wordMap in valuesList) {
            wordMap['key'] = key; // Add the key as an identifier
            savedWord.add(wordMap);
          }
        } catch (e) {
          print('Error decoding value to Map: $e');
        }
      }
    }

    return savedWord;
  }
}
