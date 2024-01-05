import 'package:flutter/material.dart';

import '../../entities/word.dart';

class WordPage extends StatelessWidget {
  WordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Word word = ModalRoute.of(context)!.settings.arguments as Word;
    return const Scaffold(
      body: Center(
        child: Text('word page'),
      ),
    );
  }
}
