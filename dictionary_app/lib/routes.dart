import 'package:dictionary_app/pages/favourite_words/favourite_words_page.dart';
import 'package:dictionary_app/pages/home/home_page.dart';
import 'package:dictionary_app/pages/word/word_page.dart';
import 'package:dictionary_app/pages/word_history/word_history_page.dart';
import 'package:dictionary_app/pages/words_list/words_list_page.dart';
import 'package:dictionary_app/providers.dart';
import 'package:dictionary_app/repositories/words_repository.dart';

final routes = {
  '/': (context) => HomePage(repository: getIt.get<WordsRepository>()),
  '/wordsList': (context) => WordsListPage(),
  '/wordPage': (context) => WordPage(),
  '/wordHistory': (context) => WordHistoryPage(),
  '/favouriteWords': (context) => FavouriteWordsPage(),
};
