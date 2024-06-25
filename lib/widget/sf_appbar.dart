import 'package:flutter/material.dart';

class SfAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? _title;
  final bool showBackArrow;
  final VoidCallback? onIconPressed;

  SfAppBar(this._title, {this.showBackArrow = true, this.onIconPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.purple,
      title: Text(
        _title ?? "SafeMind",
        style: const TextStyle(color: Colors.white),
      ),
      leading: IconButton(
        icon: Icon(
          showBackArrow ? Icons.arrow_back : Icons.clear,
          color: Colors.white,
        ),
        onPressed: onIconPressed ?? () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
