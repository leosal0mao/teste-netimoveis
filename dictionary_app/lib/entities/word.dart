import 'dart:convert';

import 'package:dictionary_app/entities/meanings.dart';

class Word {
  String? word;
  String? phonetic;
  String? origin;
  List<Meanings>? meanings;

  Word({
    this.word,
    this.phonetic,
    this.origin,
    this.meanings,
  });

  Map<String, dynamic> toMap() {
    return {
      'word': word,
      'phonetic': phonetic,
      'origin': origin,
      'meanings': meanings?.map((x) => x.toMap()).toList
    };
  }

  factory Word.fromMap(Map<String, dynamic> map) {
    return Word(
        word: map['word'] ?? '',
        phonetic: map['phonetic'] ?? '',
        origin: map['origin'] ?? '',
        meanings: map['meanings'] ?? '');
  }

  String toJson() => json.encode(toMap());

  factory Word.fromJson(String source) => Word.fromMap(json.decode(source));
}
