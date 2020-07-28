import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:twenty_four_game/screens/begin_screen.dart';
import 'package:twenty_four_game/screens/settings.dart';
import 'package:twenty_four_game/screens/time_trial/time_up.dart';
import 'package:twenty_four_game/transitions.dart';
import 'screens/home.dart';
import 'screens/time_trial/time_trial.dart';
import 'screens/practice/normal.dart';
import 'screens/how_to_play.dart';
import './csv_reader.dart';
import 'themes/styles.dart';

const MainColor = const Color.fromRGBO(207, 232, 255, 1.0);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return StatefulWrapper(
      onInit: () async {
        Database.fetchVenueDatabase();
      },
      child: MaterialApp(
        theme: AppTheme(),
        home: HomeTwo(),
        initialRoute: '/',
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return FadeRoute(page: HomeTwo());
              break;
            case '/normal':
              return FadeRoute(page: Normal());
              break;
            case '/time_trial':
              return FadeRoute(page: TimeTrial());
              break;
            case '/begin_screen1':
              return MaterialPageRoute(
                  builder: (context) => BeginScreen('/time_trial'));
              break;
            case '/begin_screen2':
              return MaterialPageRoute(
                  builder: (context) => BeginScreen('/normal'));
              break;
            case '/time_up':
              return FadeRoute(page: AnimationStation());
              break;
            case '/previous_q':
              return FadeRoute(page: AnsweredQuestions());
              break;
            case '/how_to_play':
              return FadeRoute(page: HowToPlay());
              break;
            case '/settings':
              return FadeRoute(page: Settings());
              break;
          }
          return MaterialPageRoute(builder: (context) => HomeTwo());
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
    if (widget.onInit != null) {
      widget.onInit();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
