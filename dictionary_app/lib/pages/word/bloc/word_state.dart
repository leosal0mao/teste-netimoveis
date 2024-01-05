part of 'word_bloc.dart';

abstract class WordState {}

class WordInitialState extends WordState {}

class WordLoadingState extends WordState {}

class WordFailureState extends WordState {
  final String message;

  WordFailureState(this.message);
}

class WordSucessState extends WordState {
  final Word response;
  final bool? isLoading;

  WordSucessState({
    required this.response,
    this.isLoading = false,
  });
}
