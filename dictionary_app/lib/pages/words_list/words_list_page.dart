import 'package:dictionary_app/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/words_list_bloc.dart';
import 'widgets/word_list_tile.dart';

class WordsListPage extends StatefulWidget {
  const WordsListPage({super.key});

  @override
  State<WordsListPage> createState() => _WordsListPageState();
}

class _WordsListPageState extends State<WordsListPage> {
  var wordsListBloc = getIt.get<WordsListBloc>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    wordsListBloc.close(); //dispose unused bloc to prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredWords = [];

    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
      child: BlocProvider(
        create: (context) => wordsListBloc,
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                // filteredWords = snapshot.data!.where((word) {
                //   return word['word']
                //       .toLowerCase()
                //       .contains(value.toLowerCase());
                // }).toList();
              },
              decoration: InputDecoration(
                labelText: 'Search word',
                hintText: 'Enter a word',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
            BlocBuilder<WordsListBloc, WordsListState>(
              builder: (context, state) {
                if (state is WordsListLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is WordsListFailure) {
                  return Center(child: Text(state.message!));
                } else if (state is WordsListSuccess) {
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.data.length,
                      itemBuilder: (context, index) {
                        return WordListTile(
                          title: state.data[index].word!,
                          word: state.data[index],
                        );
                      },
                    ),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }
}
