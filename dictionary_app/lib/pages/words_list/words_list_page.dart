import 'package:dictionary_app/pages/words_list/bloc/words_list_controller.dart';
import 'package:dictionary_app/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/database_helper.dart';
import 'bloc/words_list_bloc.dart';

class WordsListPage extends StatefulWidget {
  const WordsListPage({super.key});

  @override
  State<WordsListPage> createState() => _WordsListPageState();
}

class _WordsListPageState extends State<WordsListPage> {
  late final WordsListController wordsListController;
  late final WordsListBloc wordsListBloc;

  Future<List<Map<String, dynamic>>> _getWords() async {
    final db = await DatabaseHelper.instance.database;
    return await db.query('words');
  }

  @override
  void initState() {
    _getWords();

    super.initState();
  }

  @override
  void dispose() {
    wordsListBloc.close(); //dispose unused bloc to prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return BlocProvider(
    //   create: (context) => wordsListBloc,
    //   child: BlocBuilder<WordsListBloc, WordsListState>(
    //     builder: (context, state) {
    //       if (state is WordsListLoading) {
    //         return const Center(child: CircularProgressIndicator());
    //       } else if (state is WordsListSuccess) {
    //         return ListView.builder(
    //           itemCount: state.data.length,
    //           itemBuilder: (context, index) {
    //             final word = state.data[index];
    //             return ListTile(
    //               title: Text(word.word!),
    //             );
    //           },
    //         );
    //       } else if (state is WordsListFailure) {
    //         return Center(child: Text(state.message!));
    //       }
    //       return Container();
    //     },
    //   ),
    // );
    return Container(
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: _getWords(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index]['word']),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          // By default, show a loading spinner.
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
