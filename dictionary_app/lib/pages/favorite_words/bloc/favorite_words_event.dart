part of 'favorite_words_bloc.dart';

abstract class FavoriteWordsEvent {}

class LoadFavoriteWordsEvent extends FavoriteWordsEvent {
  final List<Word> data;
  LoadFavoriteWordsEvent({required this.data});
}
