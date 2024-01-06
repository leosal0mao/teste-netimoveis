part of 'favorite_words_bloc.dart';

abstract class FavoriteWordsState {}

class FavoriteWordsInitial extends FavoriteWordsState {}

class FavoriteWordsLoading extends FavoriteWordsState {}

class FavoriteWordsFailure extends FavoriteWordsState {
  final String? message;

  FavoriteWordsFailure({this.message});
}

class FavoriteWordsSuccess extends FavoriteWordsState {
  final List<Map<String, dynamic>> data;

  FavoriteWordsSuccess({
    required this.data,
  });
}
