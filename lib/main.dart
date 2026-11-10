import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:twenty_four_game/screens/begin_screen.dart';
import 'package:twenty_four_game/screens/multiplayer/multiplayer.dart';
import 'package:twenty_four_game/screens/settings.dart';
import 'package:twenty_four_game/screens/time_trial/time_up.dart';
import 'package:twenty_four_game/screens/wrapper.dart';
import 'package:twenty_four_game/services/auth.dart';
import 'package:twenty_four_game/transitions.dart';
import 'models/user.dart';
import 'screens/home.dart';
import 'screens/time_trial/time_trial.dart';
import 'screens/practice/normal.dart';
import 'screens/how_to_play.dart';
import './csv_reader.dart';
import 'themes/styles.dart';

const mainColor = Color.fromRGBO(207, 232, 255, 1.0);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<AppUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: StatefulWrapper(
        onInit: () {
          Database.fetchVenueDatabase();
        },
        child: MaterialApp(
          theme: appTheme(),
          home: const Wrapper(),
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              case '/home':
                return FadeRoute(page: const HomeTwo());
              case '/normal':
                return FadeRoute(page: const Normal());
              case '/time_trial':
                return FadeRoute(page: TimeTrial());
              case '/begin_screen1':
                return MaterialPageRoute(
                    builder: (context) => const BeginScreen('/time_trial'));
              case '/begin_screen2':
                return MaterialPageRoute(
                    builder: (context) => const BeginScreen('/normal'));
              case '/time_up':
                return FadeRoute(page: const AnimationStation());
              case '/previous_q':
                return FadeRoute(page: const AnsweredQuestions());
              case '/how_to_play':
                return FadeRoute(page: const HowToPlay());
              case '/settings':
                return FadeRoute(page: const Settings());
              case '/multiplayer':
                return FadeRoute(page: const Multiplayer());
            }
            return MaterialPageRoute(builder: (context) => const HomeTwo());
          },
        ),
      ),
    );
  }
}

class StatefulWrapper extends StatefulWidget {
  final VoidCallback onInit;
  final Widget child;

  const StatefulWrapper({super.key, required this.onInit, required this.child});

  @override
  State<StatefulWrapper> createState() => _StatefulWrapperState();
}

class _StatefulWrapperState extends State<StatefulWrapper> {
  @override
  void initState() {
    super.initState();
    widget.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
