import 'package:flutter/material.dart';

import './text_output.dart';

class TextControl extends StatefulWidget {
  @override
  _TextControlState createState() => _TextControlState();
}

class _TextControlState extends State<TextControl> {
  String _textOnScreen = 'Initial Text';

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      RaisedButton(
          child: Text('Change TExt'),
          onPressed: () {
            setState(() {
              _textOnScreen = 'I changed the text';
            });
          },
          color: Color.fromARGB(255, 66, 165, 245)),
      TextOutput(_textOnScreen),
    ], mainAxisAlignment: MainAxisAlignment.center);
  }
}
