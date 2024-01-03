import 'dart:convert';

class Definitions {
  String? definition;
  String? example;

  Definitions({
    this.example,
    this.definition,
  });

  Map<String, dynamic> toMap() {
    return {
      'definition': definition,
      'example': example,
    };
  }

  factory Definitions.fromMap(Map<String, dynamic> map) {
    return Definitions(
      definition: map['definition'] ?? '',
      example: map['example'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Definitions.fromJson(String source) =>
      Definitions.fromMap(json.decode(source));
}
