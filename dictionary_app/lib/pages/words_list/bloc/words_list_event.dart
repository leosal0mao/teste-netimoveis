part of 'words_list_bloc.dart';

abstract class WordsListEvent {}

class LoadWordsEvent extends WordsListEvent {
  final int pageNumber;

  LoadWordsEvent({required this.pageNumber});
}
