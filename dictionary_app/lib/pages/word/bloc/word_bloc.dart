import 'package:dictionary_app/entities/word.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'word_state.dart';
part 'word_event.dart';

class WordBloc extends Bloc<WordEvent, WordState> {
  final Word word;

  WordBloc(this.word) : super(WordInitialState()) {
    on<WordEvent>((event, emit) {});
  }
}
