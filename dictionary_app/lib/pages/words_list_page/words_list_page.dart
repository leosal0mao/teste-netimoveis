import 'package:flutter/material.dart';

class WordsListPage extends StatefulWidget {
  const WordsListPage({super.key});

  @override
  State<WordsListPage> createState() => _WordsListPageState();
}

class _WordsListPageState extends State<WordsListPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('words list page'),
      ),
    );
  }
}
