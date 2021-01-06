import 'package:flutter/material.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
                onPressed: () {},
                color: Color.fromARGB(255, 66, 165, 245)),
            Text('HELLO WORLD'),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    ));
  }
}
