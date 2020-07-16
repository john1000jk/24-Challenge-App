import 'package:flutter/material.dart';
import 'package:twenty_four_game/begin_screen.dart';
import 'package:twenty_four_game/transitions.dart';
import './home.dart';
import './time_trial.dart';
import './normal.dart';
import './how_to_play.dart';
import './csv_reader.dart';
import './numbers.dart';
import 'dart:async' show Future;


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return StatefulWrapper(
      onInit: () async {
        await Database.fetchVenueDatabase().then((result) {
          Normal().build(context);
        });
      },
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.blue,
          accentColor: Colors.white,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text("24 Challenge"),
          ),
          body: Home(),
        ),
        initialRoute: '/',
        routes: {
          // When navigating to the "/timetrial" route, build the SecondScreen widget.
          '/how_to_play': (context) => HowToPlay(),
        },
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(builder: (context)=> Home());
              break;
            case '/normal':
              return FadeRoute(page: Normal());
              break;
            case '/time_trial':
              return FadeRoute(page: TimeTrial());
              break;
            case '/begin_screen1':
              return MaterialPageRoute(builder: (context) => BeginScreen('/time_trial'));
              break;
            case '/begin_screen2':
              return MaterialPageRoute(builder: (context) => BeginScreen('/normal'));
              break;
          }
          return MaterialPageRoute(builder: (context) => Home());
        },
      ),
    );
  }
}

class StatefulWrapper extends StatefulWidget {
  final Function onInit;
  final Widget child;
  const StatefulWrapper({@required this.onInit, @required this.child});
  @override
  _StatefulWrapperState createState() => _StatefulWrapperState();
}
class _StatefulWrapperState extends State<StatefulWrapper> {
  @override
  void initState() {
    if(widget.onInit != null) {
      widget.onInit();
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
