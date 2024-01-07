import 'package:localstorage/localstorage.dart';

class MyLocalStorage {
  final LocalStorage storage = LocalStorage('cached_words.json');

  Future<void> saveData(String key, String value) async {
    return await storage.setItem(key, value);
  }

  Future<String?> getData(String key) async {
    return await storage.getItem(key);
  }
}
