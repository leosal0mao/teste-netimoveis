import 'package:dictionary_app/entities/word.dart';
import 'package:dictionary_app/repositories/words_repository.dart';
import 'package:flutter/material.dart';

import '../../services/load_json_asset.dart';

enum Status { loading, success, error }

class WordsListController {
  List<Word> words = [];
  WordsRepository? wordsRepository;
  ValueNotifier<Status> status = ValueNotifier(Status.loading);

  WordsListController({this.wordsRepository}) {
    loadWords();
  }

  loadWords() async {
    status.value = Status.loading;
    words = await loadJsonAsset('assets/words_dictionary.json');
    status.value = Status.success;
  }

  errorLoadingWord() async {
    status.value = Status.error;
  }
}
