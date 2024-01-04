import 'package:dictionary_app/widgets/custom_appbar.dart';
import 'package:dictionary_app/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  CustomScaffold({super.key, this.body});

  Widget? body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(),
      body: body,
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
