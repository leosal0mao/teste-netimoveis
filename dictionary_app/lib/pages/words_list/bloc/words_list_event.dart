part of 'words_list_bloc.dart';

abstract class WordsListEvent {}

class LoadWordsEvent extends WordsListEvent {
  final List<Word> wordsList;

  LoadWordsEvent({required this.wordsList});
}
