import 'package:flutter/material.dart';

class SfAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? _title;
  final IconData backIcon;
  final VoidCallback? onIconPressed;

  SfAppBar(this._title, {this.backIcon = Icons.arrow_back , this.onIconPressed,});

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
          backIcon,
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
