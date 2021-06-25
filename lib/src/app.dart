import 'package:calculator/src/ui/main_page.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
   App({ Key key }) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
    );
  }
}