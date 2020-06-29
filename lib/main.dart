import 'package:flutter/material.dart';
import 'package:timer/screen/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pill reminder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        buttonColor: Colors.red
      ),
      initialRoute: '/',
      routes:  <String, WidgetBuilder>{
        '/': (BuildContext context) => HomeScreen(),
      },
    );
  }
}
