import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../providers.dart';

class MySharedPreferences {
  SharedPreferences? sharedPreferences;
  static const String _keyData = 'myData';
  static const String _keyExpiration = 'expirationTime';

  MySharedPreferences({this.sharedPreferences});

  Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  // Function to save data with an expiration date to SharedPreferences
  Future<bool> saveDataWithExpiration(
      String data, Duration expirationDuration) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      DateTime expirationTime = DateTime.now().add(expirationDuration);
      await prefs.setString(_keyData, data);
      await prefs.setString(_keyExpiration, expirationTime.toIso8601String());
      print('Data saved to SharedPreferences.');
      return true;
    } catch (e) {
      print('Error saving data to SharedPreferences: $e');
      return false;
    }
  }

  // Function to get data from SharedPreferences if it's not expired
  Future<String?> getDataIfNotExpired() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? data = prefs.getString(_keyData);
      String? expirationTimeStr = prefs.getString(_keyExpiration);
      if (data == null || expirationTimeStr == null) {
        print('No data or expiration time found in SharedPreferences.');
        return null; // No data or expiration time found.
      }

      DateTime expirationTime = DateTime.parse(expirationTimeStr);
      if (expirationTime.isAfter(DateTime.now())) {
        print('Data has not expired.');
        // The data has not expired.
        return data;
      } else {
        // Data has expired. Remove it from SharedPreferences.
        await prefs.remove(_keyData);
        await prefs.remove(_keyExpiration);
        print('Data has expired. Removed from SharedPreferences.');
        return null;
      }
    } catch (e) {
      print('Error retrieving data from SharedPreferences: $e');
      return null;
    }
  }

  Future<void> saveWordsCache(
      {String? key, dynamic object2, Duration? expiration}) async {
    var now = DateTime.now();
    var object2String = jsonEncode(object2);
    var expirationString = now.add(expiration!).toIso8601String();

    var mySharedPreferences = getIt<MySharedPreferences>();
    await mySharedPreferences.sharedPreferences?.setString(key!, object2String);
    await mySharedPreferences.sharedPreferences
        ?.setString('$key-expiration', expirationString);
  }

  Future<dynamic> getWordsCache(String key) async {
    var object2String = sharedPreferences?.getString(key);
    var expirationString = sharedPreferences?.getString('$key-expiration');

    if (object2String != null && expirationString != null) {
      var now = DateTime.now();
      var expirationDate = DateTime.parse(expirationString);

      if (now.isBefore(expirationDate)) {
        return jsonDecode(object2String);
      } else {
        // Data has expired. Remove it from SharedPreferences.
        await sharedPreferences?.remove(key);
        await sharedPreferences?.remove('$key-expiration');
        print('Data has expired. Removed from SharedPreferences.');
        return null;
      }
    } else {
      return null;
    }
  }

  // Function to clear data from SharedPreferences
  Future<void> clearData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove(_keyData);
      await prefs.remove(_keyExpiration);
      print('Data cleared from SharedPreferences.');
    } catch (e) {
      print('Error clearing data from SharedPreferences: $e');
    }
  }
}
