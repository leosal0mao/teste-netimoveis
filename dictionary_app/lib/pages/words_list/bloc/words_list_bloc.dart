import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../entities/word.dart';
import '../../../services/database_helper.dart';

part 'words_list_event.dart';
part 'words_list_state.dart';

class WordsListBloc extends Bloc<WordsListEvent, WordsListState> {
  WordsListBloc() : super(WordsListLoading());

  @override
  Stream<WordsListState> mapEventToState(WordsListEvent event) async* {
    if (event is LoadWordsEvent) {
      try {
        yield WordsListLoading();
        final db = await DatabaseHelper.instance.database;
        List<Map<String, dynamic>> newWords = await db.query('words');

        // You should convert the list of maps to a list of Word entities
        List<Word> wordList = newWords.map((e) => Word.fromMap(e)).toList();

        yield WordsListSuccess(data: wordList);
      } catch (e) {
        yield WordsListFailure(message: e.toString());
      }
    }
  }
}
