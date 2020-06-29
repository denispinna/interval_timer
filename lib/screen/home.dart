import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timer/component/clock.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TimerWidget(),
    );
  }
}
