import 'package:flutter/material.dart';
import 'package:flutter_circular_text/circular_text.dart';
import 'package:provider/provider.dart';
import 'package:twenty_four_game/models/user.dart';
import 'package:twenty_four_game/audio_player.dart';
import 'package:twenty_four_game/themes/styles.dart';
import 'package:twenty_four_game/services/auth.dart';
import '../background_painter.dart';

class HomeTwo extends StatefulWidget {
  const HomeTwo({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeTwoState();
  }
}

class _HomeTwoState extends State<HomeTwo> with TickerProviderStateMixin {
  final AuthService _authService = AuthService();
  final List<String> _buttonNames = ['Time Trial', 'Multiplayer', 'Practice', 'How to Play'];
  final List<String> _buttonRoutes = ['/begin_screen1', '/multiplayer', '/normal', '/how_to_play'];
  /// True while a button is opening its screen, so a double tap can't open
  /// it twice. Cleared when the player comes back to this screen.
  bool _navigating = false;
  List<Color> primeColors = [
    Color.fromRGBO(29, 242, 242, 1.0),
    Color.fromRGBO(29, 168, 242, 1.0),
    Color.fromRGBO(29, 89, 242, 1.0),
  ];
  List<Color> secondColors = [
    Color.fromRGBO(29, 168, 242, 1.0),
    Color.fromRGBO(29, 89, 242, 1.0),
    Color.fromRGBO(89, 29, 242, 1.0),
  ];

  late final List<AnimationController> _controllers;
  final List<double> _buttonScales = List.filled(4, 1.0);

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      4,
      (_) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 100),
        lowerBound: 0,
        upperBound: .1,
      )..addListener(() {
          setState(() {});
        }),
    );
  }

  @override
  void dispose() {
    for (int i = 0; i < _controllers.length; i++) {
      _controllers[i].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    for (int i = 0; i < _controllers.length; i++) {
      _buttonScales[i] = 1 - _controllers[i].value;
    }

    return Scaffold(
      backgroundColor: accentColor,
      body: SizedBox(
        width: width,
        height: height,
        child: Stack(
          children: [
            CustomPaint(
              painter: BackgroundPainter(),
              child: SizedBox(
                width: width,
                height: height,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 60.0, bottom: 5.0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(4.0),
                          width: height * .3,
                          height: height * .3,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue,
                          ),
                          child: CircularText(
                            children: [
                              TextItem(
                                text: Text(
                                  "Arithmetic".toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                space: 15,
                                startAngle: -90,
                                startAngleAlignment: StartAngleAlignment.center,
                                direction: CircularTextDirection.clockwise,
                              ),
                              TextItem(
                                text: Text(
                                  "Challenge".toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                space: 16,
                                startAngle: 90,
                                startAngleAlignment: StartAngleAlignment.center,
                                direction: CircularTextDirection.anticlockwise,
                              ),
                              TextItem(
                                text: Text(
                                  "+".toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                space: 10,
                                startAngle: 180,
                                startAngleAlignment: StartAngleAlignment.center,
                                direction: CircularTextDirection.clockwise,
                              ),
                              TextItem(
                                text: Text(
                                  "+".toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                space: 10,
                                startAngle: 0,
                                startAngleAlignment: StartAngleAlignment.center,
                                direction: CircularTextDirection.clockwise,
                              ),
                            ],
                            radius: 135,
                            position: CircularTextPosition.inside,
                          ),
                        ),
                        Container(
                          width: height * .208,
                          height: height * .208,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: FittedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                '24',
                                style: TextStyle(
                                    fontSize: 150, color: Colors.blue),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Spacer(),
                  _animatedButton(0),
                  Spacer(),
                  _animatedButton(1),
                  Spacer(),
                  _animatedButton(2),
                  Spacer(),
                  _animatedButton(3),
                  Spacer(),
                ],
              ),
            ),
            Positioned(
              right: 15,
              top: 25,
              child: SizedBox(
                width: 50,
                height: 50,
                child: Ink(
                  child: FittedBox(
                    child: MaterialButton(
                      onPressed: () {
                        setState(() {
                          AudioP.canPlay = !AudioP.canPlay;
                        });
//                        Navigator.pushNamed(context, '/settings');
                      },
                      child: Icon(
                        (AudioP.canPlay) ? Icons.volume_up : Icons.volume_off,
                        size: 5000,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Signing in is only needed for Multiplayer, so Logout only
            // shows while someone is signed in.
            if (Provider.of<AppUser?>(context) != null)
              Positioned(
                left: 5,
                top: 25,
                child: SizedBox(
                  height: 50,
                  child: TextButton.icon(
                      onPressed: () async {
                        await _authService.signOut();
                      },
                      icon: const Icon(Icons.person),
                      label: const Text('Logout', style: TextStyle(fontSize: 20),)
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// Plays the button's release animation, then opens its screen.
  Future<void> _openScreen(int index) async {
    if (_navigating) return;
    _navigating = true;
    try {
      await _controllers[index].reverse();
      if (_buttonNames[index] == 'Practice') {
        try {
          await AudioP.loadMusic();
        } catch (e) {
          debugPrint('Could not start music: $e');
        }
      }
      if (!mounted) return;
      // Completes when the player returns to the home screen.
      await Navigator.pushNamed(context, _buttonRoutes[index]);
    } finally {
      _navigating = false;
    }
  }

  Widget _animatedButton(int index) => GestureDetector(
        onTapDown: (TapDownDetails details) {
          _controllers[index].forward();
        },
        onTapUp: (TapUpDetails details) => _openScreen(index),
        // Finger slid off the button: just restore it, don't open anything.
        onTapCancel: () => _controllers[index].reverse(),
        child: Transform.scale(
          scale: _buttonScales[index],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 275,
              height: 75,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
//                gradient: LinearGradient(
//                    begin: Alignment.topLeft,
//                    end: Alignment.bottomRight,
//                    colors: [
//                      primeColors[index],
//                      secondColors[index],
//                    ]),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x80000000),
                    blurRadius: 10.0,
                    offset: Offset(0.0, 5.0),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  _buttonNames[index],
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Colors.indigo,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
