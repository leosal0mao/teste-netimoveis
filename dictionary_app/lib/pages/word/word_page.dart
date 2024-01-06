import 'dart:ffi';

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
  WordPage({super.key, required this.word});

  @override
  State<WordPage> createState() => _WordPageState();
}

class _WordPageState extends State<WordPage> {
  var wordBloc = getIt.get<WordBloc>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    wordBloc.add(FetchWordEvent(word: widget.word));
    return Scaffold(
        appBar: AppBar(),
        body: BlocProvider(
          create: (context) => context.read<WordBloc>(),
          child: BlocBuilder<WordBloc, WordState>(
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
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ));
  }
}
