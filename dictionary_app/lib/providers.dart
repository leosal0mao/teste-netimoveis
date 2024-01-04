import 'package:dictionary_app/data/words_remote_source.dart';
import 'package:dictionary_app/pages/word/word_controller.dart';
import 'package:dictionary_app/pages/words_list/words_list_controller.dart';
import 'package:dictionary_app/repositories/words_repository.dart';
import 'package:dictionary_app/services/shared_preferences_cached_data.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

setupProviders() {
  getIt.registerSingleton<MySharedPreferences>(MySharedPreferences());

  getIt.registerLazySingleton<WordsRemoteSource>(
    () => WordsRemoteSource(getIt.get<MySharedPreferences>()),
  );

  getIt.registerLazySingleton<WordsRepository>(
    () => WordsRepository(
      remoteSource: WordsRemoteSource(MySharedPreferences()),
      sharedPreferences: getIt.get<MySharedPreferences>(),
    ),
  );

  getIt.registerLazySingleton<WordsListController>(() => WordsListController());
  getIt.registerLazySingleton<WordController>(() => WordController());
}
