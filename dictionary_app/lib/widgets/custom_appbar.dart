import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
          icon: const Icon(Icons.list),
          onPressed: () => Navigator.pushNamed(context, '/wordsList'),
        ),
        IconButton(
          icon: const Icon(Icons.history),
          onPressed: () => Navigator.pushNamed(context, '/wordHistory'),
        ),
        IconButton(
          icon: const Icon(Icons.favorite_outline),
          onPressed: () => Navigator.pushNamed(context, '/favouriteWords'),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
