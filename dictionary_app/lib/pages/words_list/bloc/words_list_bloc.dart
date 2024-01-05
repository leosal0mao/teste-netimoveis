import 'package:dictionary_app/pages/words_list/bloc/words_list_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../entities/word.dart';

part 'words_list_event.dart';
part 'words_list_state.dart';

class WordsListBloc extends Bloc<WordsListEvent, WordsListState> {
  final WordsListController wordsListController;

  WordsListBloc(this.wordsListController) : super(WordsListLoading());

  @override
  Stream<WordsListState> mapEventToState(WordsListEvent event) async* {
    if (event is LoadWordsEvent) {
      try {
        if (state is WordsListLoading) {
          List<Word> newWords = await wordsListController.loadWordsToPage(
              pageNumber: event.pageNumber) as List<Word>;

          bool hasReachedMax = newWords.length < 20;
          yield WordsListSuccess(data: newWords, hasReachedMax: hasReachedMax);
        }
      } catch (e) {
        yield WordsListFailure(message: e.toString());
      }
    }
  }
}
