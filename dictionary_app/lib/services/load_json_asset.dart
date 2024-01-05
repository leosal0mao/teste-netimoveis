import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

// Future<List<String>> loadJsonAsset(
//     {String? path, int? pageNumber, int? itemsPerPage}) async {
//   var jsonString = await rootBundle.loadString(path!);

//   Map<String, dynamic> jsonList = jsonDecode(jsonString);
//   List<String> keys = jsonList.keys.toList();

//   return paginate(keys, pageNumber!, itemsPerPage!);
// }

// List<String> paginate(List<String> list, int pageNumber, int itemsPerPage) {
//   int start = (pageNumber - 1) * itemsPerPage;
//   int end =
//       (start + itemsPerPage > list.length) ? list.length : start + itemsPerPage;
//   return list.sublist(start, end);
// }

Stream<String> readJsonLines(String path) async* {
  final byteStream = await rootBundle.loadString(path);
  final utf8Decoder = utf8.decoder;
  final lines = utf8Decoder.bind(byteStream as Stream<List<int>>);
  await for (final line in lines) {
    yield line;
  }
}

Future<List<String>> processJsonLines(
    {String? path, int? pageNumber, int? itemsPerPage}) async {
  final keys = <String>[];
  await for (final line in readJsonLines(path!)) {
    if (keys.length >= pageNumber! * itemsPerPage!) {
      break;
    }
    final jsonObject = jsonDecode(line);
    final key = jsonObject.keys.first;
    keys.add(key);
  }
  return keys;
}
