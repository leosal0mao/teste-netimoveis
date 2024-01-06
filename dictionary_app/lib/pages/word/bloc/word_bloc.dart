import 'package:dictionary_app/entities/word.dart';
import 'package:dictionary_app/entities/word_not_found.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repositories/words_repository.dart';

part 'word_state.dart';
part 'word_event.dart';

class WordBloc extends Bloc<WordEvent, WordState> {
  final WordsRepository wordsRepository;
  Set<Word> favoriteWords = {};

  WordBloc({required this.wordsRepository}) : super(WordInitialState()) {
    on<FetchWordEvent>(_onFetchWord);
    on<SaveToFavoriteEvent>(_saveWordToFavorite);
  }

  Future<void> _onFetchWord(
    FetchWordEvent event,
    Emitter<WordState> emit,
  ) async {
    try {
      emit(WordLoadingState());
      final fetchedWord = await wordsRepository.getWord(event.word);

      (fetchedWord is WordNotFound)
          ? emit(WordNotFoundState(
              word: fetchedWord,
              message:
                  'This word does not exist on the dictionary, do a new search'))
          : emit(WordSuccessState(data: fetchedWord));
    } catch (e) {
      emit(WordFailureState(message: e.toString()));
    }
  }

  void _toggleFavoriteWord(Word word) {
    favoriteWords.contains(word)
        ? favoriteWords.remove(word)
        : favoriteWords.add(word);
  }

  Future<void> _saveWordToFavorite(
    SaveToFavoriteEvent event,
    Emitter<WordState> emit,
  ) async {
    final currentState = state;
    if (currentState is WordSuccessState) {
      _toggleFavoriteWord(currentState.data);
      emit(WordSuccessState(data: currentState.data));
    }
  }
}
