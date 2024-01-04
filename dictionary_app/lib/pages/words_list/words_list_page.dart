import 'package:dictionary_app/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

import '../../providers.dart';
import '../../widgets/custom_scaffold.dart';
import 'words_list_controller.dart';

class WordsListPage extends StatefulWidget {
  const WordsListPage({super.key});

  @override
  State<WordsListPage> createState() => _WordsListPageState();
}

class _WordsListPageState extends State<WordsListPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Container(),
    );
  }
}
