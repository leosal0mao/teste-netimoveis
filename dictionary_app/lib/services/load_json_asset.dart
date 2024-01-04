import 'dart:convert';

import 'package:flutter/services.dart';

Future<dynamic> loadJsonAsset(String path) async {
  String jsonString = await rootBundle.loadString(path);
  Map<String, dynamic> jsonData = jsonDecode(jsonString);

  return jsonData.keys.toList();
}
