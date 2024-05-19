import 'package:flutter/material.dart';

class SfPrimaryButton extends StatelessWidget {
  final String _title;
  final VoidCallback _callback;
  SfPrimaryButton(this._title, this._callback);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      elevation: 5.0,
      minWidth: double.infinity,
      clipBehavior: Clip.antiAlias,
      height: 50,
      color: Colors.purple,
      child:
          Text(_title, style: TextStyle(fontSize: 16.0, color: Colors.white)),
      onPressed: _callback,
    );
  }
}
