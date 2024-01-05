import 'package:flutter/material.dart';

import '../../../entities/word.dart';

class WordListTile extends StatelessWidget {
  String title;
  Word word;

  WordListTile({
    super.key,
    required this.title,
    required this.word,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.pushNamed(
        context,
        '/wordPage',
        arguments: word,
      ),
      title: Text(title),
    );
  }
}
