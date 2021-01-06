import 'package:flutter/material.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _textOnScreen = 'This is initial text';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(title: Text('List CRUD')),
      body: Center(
        child: Column(
          children: [
            RaisedButton(
                child: Text('Button'),
                onPressed: () {
                  setState(() {
                    _textOnScreen = 'I changed the text';
                  });
                },
                color: Color.fromARGB(255, 66, 165, 245)),
            Text(_textOnScreen),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    ));
  }
}
