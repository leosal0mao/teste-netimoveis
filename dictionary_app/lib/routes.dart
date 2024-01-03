import 'package:dictionary_app/pages/home/home_page.dart';
import 'package:dictionary_app/repositories/words_repository.dart';

final routes = {
  '/': (context) => HomePage(repository: WordsRepository()),
};
