part of 'word_bloc.dart';

abstract class WordEvent {}

class FetchWordEvent extends WordEvent {
  Word word;

  FetchWordEvent({required this.word});
}

class SaveToFavoriteEvent extends WordEvent {
  Word word;
  bool isFavorite;

  SaveToFavoriteEvent({required this.word, required this.isFavorite});
}
