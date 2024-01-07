import 'dart:async';

import 'package:dictionary_app/pages/favorite_words/bloc/favorite_words_bloc.dart';
import 'package:dictionary_app/pages/word/widgets/meanings_container.dart';
import 'package:dictionary_app/pages/word/widgets/play_audio_button.dart';
import 'package:dictionary_app/pages/word/widgets/word_container.dart';
import 'package:dictionary_app/widgets/failure_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../providers.dart';
import 'bloc/word_bloc.dart';

class WordPage extends StatefulWidget {
  final String word;
  bool isFavorite;

  WordPage({super.key, required this.word, required this.isFavorite});

  @override
  State<WordPage> createState() => _WordPageState();
}

class _WordPageState extends State<WordPage> {
  var wordBloc = getIt.get<WordBloc>();
  var favoriteBloc = getIt.get<FavoriteWordsBloc>();

  @override
  void initState() {
    wordBloc.add(FetchWordEvent(word: widget.word));

    super.initState();
  }

  @override
  void dispose() {
    wordBloc.close();
    favoriteBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${widget.word} Details'),
          actions: [
            BlocProvider(
                create: (context) => favoriteBloc,
                child: BlocConsumer<FavoriteWordsBloc, FavoriteWordsState>(
                    listener: (context, state) {
                  if (state is FavoriteWordsFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content:
                              Text('Word already exists on your favourites')),
                    );
                  }
                  if (state is FavoriteWordSavedSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Word added to favorites')),
                    );
                    setState(() {
                      widget.isFavorite = true;
                    });
                  }
                  if (state is FavoriteWordDeletedSuccess) {
                    if (state is FavoriteWordSavedSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Word deleted from favorites')),
                      );
                      setState(() {
                        widget.isFavorite = false;
                      });
                    }
                  }
                  if (state is FavoriteWordsLoading) {
                    favoriteBloc
                        .add(IsFavoriteEvent(isFavorite: widget.isFavorite));
                  }
                  if (state is IsFavoriteSuccess) {
                    setState(() {
                      widget.isFavorite = true;
                    });
                  }
                }, builder: (context, state) {
                  return IconButton(
                    icon: Icon(
                      state is IsFavoriteState ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                    ),
                    onPressed: () {
                      state is IsFavoriteState?
                          ? favoriteBloc
                              .add(DeleteFromFavoritesEvent(word: widget.word))
                          : favoriteBloc
                              .add(AddToFavoritesEvent(word: widget.word));
                    },
                  );
                })),
          ],
        ),
        body: BlocProvider(
          create: (context) => wordBloc,
          child: BlocConsumer<WordBloc, WordState>(
            listener: (context, state) {
              if (state is WordInitialState) {
                wordBloc.add(FetchWordEvent(word: widget.word));
              }
            },
            builder: (context, state) {
              if (state is WordInitialState) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is WordLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is WordFailureState) {
                return FailureWidget(
                  error: state.message,
                );
              }
              if (state is WordNotFoundState) {
                return Center(
                  child: Text(state.message,
                      style: const TextStyle(fontSize: 20),
                      textAlign: TextAlign.center),
                );
              }
              if (state is WordSuccessState) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        WordContainer(
                          word: state.data.word,
                          phonetic: state.data.phonetic,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            PlayAudioButton(audioText: state.data.word!),
                            const SizedBox(height: 10),
                            const Text(
                              'PLAY AUDIO',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        MeaningsContainer(
                          meaning: state.data.meanings![0].partOfSpeech,
                          definition: state
                              .data.meanings![0].definitions![0].definition,
                        )
                      ],
                    ),
                  ),
                );
              }
              return const Center(
                  child: Column(
                children: [
                  Text('Page did not enter on any bloc'),
                  CircularProgressIndicator(),
                ],
              ));
            },
          ),
        ));
  }
}
