import 'package:flutter/material.dart';

class SfAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SfAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.purple,
      iconTheme: const IconThemeData(color: Colors.white),
      title: const Text(
        "Safemind",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
