import 'package:dictionary_app/entities/word.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repositories/favorite_words_repository.dart';

part 'favorite_words_state.dart';
part 'favorite_words_event.dart';

class FavoriteWordsBloc extends Bloc<FavoriteWordsEvent, FavoriteWordsState> {
  final FavoriteWordsRepository favoriteWordsRepository;

  FavoriteWordsBloc({required this.favoriteWordsRepository})
      : super(FavoriteWordsInitial()) {
    on<LoadFavoriteWordsEvent>(_onLoadWords);
  }

  Future<void> _onLoadWords(
    LoadFavoriteWordsEvent event,
    Emitter<FavoriteWordsState> emit,
  ) async {
    try {
      final words = await favoriteWordsRepository.getFavoriteWords();
      emit(FavoriteWordsSuccess(data: words));
    } catch (e) {
      emit(FavoriteWordsFailure(message: e.toString()));
    }
  }
}
