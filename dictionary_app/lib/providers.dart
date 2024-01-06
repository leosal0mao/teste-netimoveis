import 'package:dictionary_app/data/words_remote_source.dart';
import 'package:dictionary_app/pages/word/bloc/word_bloc.dart';
import 'package:dictionary_app/pages/words_list/bloc/words_list_bloc.dart';
import 'package:dictionary_app/repositories/favorite_words_repository.dart';
import 'package:dictionary_app/repositories/words_repository.dart';
import 'package:dictionary_app/services/shared_preferences_cached_data.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupProviders() {
  getIt.registerSingleton(MySharedPreferences());

  getIt.registerSingleton<WordsRepository>(
    WordsRepository(
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

  getIt.registerLazySingleton(
      () => WordBloc(wordsRepository: getIt.get<WordsRepository>()));
}
