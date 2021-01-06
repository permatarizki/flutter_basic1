import 'package:flutter/material.dart';

class TextOutput extends StatelessWidget {
  final String _textOnScreen;
  TextOutput(this._textOnScreen);

  @override
  Widget build(BuildContext context) {
    return Text(_textOnScreen);
  }
}
