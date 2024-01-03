import 'package:dictionary_app/repositories/words_repository.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key, this.repository});

  WordsRepository? repository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () {
          repository!.getWord('word');
        },
        child: Center(
          child: Text('HomePage'),
        ),
      ),
    );
  }
}
