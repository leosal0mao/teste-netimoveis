import 'package:dictionary_app/repositories/words_repository.dart';

import '../../../services/load_json_asset.dart';

class WordsListController {
  List<String> words = [];
  int? pageNumber;
  WordsRepository? wordsRepository;

  WordsListController({this.wordsRepository, this.pageNumber = 1}) {
    loadWordsToPage(pageNumber: pageNumber!);
  }

  Future<List<String>> loadWordsToPage({required int pageNumber}) async {
    try {
      // words = await processJsonLines(
      //   path: 'assets/words_dictionary.json',
      //   pageNumber: pageNumber,
      //   itemsPerPage: 20,
      // );
      words = [];
    } catch (e) {
      throw Exception('error $e');
    }

    return words;
  }
}
