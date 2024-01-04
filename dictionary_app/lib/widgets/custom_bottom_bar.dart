import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: (int index) {
        setState(() {
          currentPageIndex = index;
        });
        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/wordsList');
            break;
          case 1:
            Navigator.pushNamed(context, '/wordHistory');
            break;
          case 2:
            Navigator.pushNamed(context, '/favouriteWords');
            break;
          default:
            break;
        }
      },
      indicatorColor: Colors.deepPurple,
      selectedIndex: currentPageIndex,
      destinations: const <Widget>[
        NavigationDestination(
          icon: Icon(Icons.list_alt),
          label: 'Word List',
        ),
        NavigationDestination(
          icon: Icon(Icons.history_rounded),
          label: 'History',
        ),
        NavigationDestination(
          icon: Icon(Icons.favorite_outline_outlined),
          label: 'Favourites',
        ),
      ],
    );
  }
}
