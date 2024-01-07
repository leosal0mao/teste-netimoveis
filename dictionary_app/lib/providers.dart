import 'package:dictionary_app/data/words_remote_source.dart';
import 'package:dictionary_app/pages/favorite_words/bloc/favorite_words_bloc.dart';
import 'package:dictionary_app/pages/word/bloc/word_bloc.dart';
import 'package:dictionary_app/pages/words_list/bloc/words_list_bloc.dart';
import 'package:dictionary_app/repositories/favorite_words_repository.dart';
import 'package:dictionary_app/repositories/words_repository.dart';
import 'package:dictionary_app/services/shared_preferences_cached_data.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupProviders() {
  getIt.registerSingleton(MySharedPreferences());

  //registered as factory because I need just 1 instance per API call
  getIt.registerFactory<WordsRepository>(
    () => WordsRepository(
      remoteSource: WordsRemoteSource(getIt.get<MySharedPreferences>()),
      sharedPreferences: getIt.get<MySharedPreferences>(),
    ),
  );

  getIt.registerLazySingleton(() => FavoriteWordsRepository());

  getIt.registerLazySingleton<WordsRemoteSource>(
    () => WordsRemoteSource(getIt.get<MySharedPreferences>()),
  );

  getIt.registerLazySingleton<WordsListBloc>(
      () => WordsListBloc(wordsRepository: getIt.get<WordsRepository>()));

  // registered as factory because I need a new instance every time the page is opened
  getIt.registerFactory<WordBloc>(() => WordBloc(
      favoriteWordsRepository: getIt.get<FavoriteWordsRepository>(),
      wordsRepository: getIt.get<WordsRepository>()));

  getIt.registerFactory(() => FavoriteWordsBloc(
      favoriteWordsRepository: getIt.get<FavoriteWordsRepository>()));
}
