import 'package:flutter/material.dart';

class SfAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? _title;
  SfAppBar(this._title);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.purple,
      iconTheme: const IconThemeData(color: Colors.white),
      title: Text(
        _title ?? "SafeMind",
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
