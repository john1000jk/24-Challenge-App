import 'package:flutter/material.dart';
import './home.dart';
import './time_trial.dart';
import './normal.dart';
import './csv_reader.dart';
import 'dart:async' show Future;


void main() async {
  runApp(MyApp());
  await Database.fetchVenueDatabase();
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("24 Challenge"),
        ),
        body: Home(),
      ),
      initialRoute: '/',
      routes: {
        // When navigating to the "/timetrial" route, build the SecondScreen widget.
        '/time_trial': (context) => TimeTrial(),
        '/normal': (context) => Normal(),
      },
    );
  }
}
