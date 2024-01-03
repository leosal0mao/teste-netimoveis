import 'package:dictionary_app/pages/home/home_page.dart';
import 'package:dictionary_app/routes.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'dictionary app',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        brightness: Brightness.dark,
      ),
      routes: routes,
    );
  }
}
