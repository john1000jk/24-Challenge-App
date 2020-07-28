import 'package:flutter/material.dart';
import 'package:flutter_circular_text/circular_text.dart';
import 'package:twenty_four_game/audio_player.dart';
import 'package:twenty_four_game/themes/styles.dart';

import '../background_painter.dart';

class HomeTwo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeTwoState();
  }
}

class _HomeTwoState extends State<HomeTwo> with TickerProviderStateMixin {
  List<String> _buttonNames = ['Time Trial', 'Practice', 'How to Play'];
  List<String> _buttonRoutes = ['/begin_screen1', '/normal', '/how_to_play'];
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

  List<AnimationController> _controllers = new List(3);
  List<double> _buttonScales = new List(3);

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 3; i++) {
      _buttonScales[i] = 1.0;
      _controllers[i] = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 100),
        lowerBound: 0,
        upperBound: .1,
      )..addListener(() {
          setState(() {});
        });
    }
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
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    for (int i = 0; i < 3; i++) {
      _buttonScales[i] = 1 - _controllers[i].value;
    }

    return Scaffold(
      backgroundColor: AppTheme().accentColor,
      body: Container(
        width: _width,
        height: _height,
        child: Stack(
          children: [
            CustomPaint(
              painter: BackgroundPainter(),
              child: Container(
                width: _width,
                height: _height,
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
                          width: _width * .6,
                          height: _width * .6,
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
                          width: _width * .41,
                          height: _width * .41,
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
                  Spacer(
                    flex: 3,
                  ),
                ],
              ),
            ),
            Positioned(
              right: 15,
              top: 25,
              child: Container(
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
          ],
        ),
      ),
    );
  }

  Widget _animatedButton(int index) => GestureDetector(
        onTapUp: (TapUpDetails details) {
          if (_buttonNames[index] == 'Practice') {
            _controllers[index].reverse().then((value) => AudioP.loadMusic()
                .then((value) =>
                    Navigator.pushNamed(context, _buttonRoutes[index])));
          } else {
            _controllers[index].reverse().then(
                (value) => Navigator.pushNamed(context, _buttonRoutes[index]));
          }
        },
        onTapDown: (TapDownDetails details) {
          _controllers[index].forward();
        },
        onTapCancel: () {
          if (_buttonNames[index] == 'Practice') {
            AudioP.loadMusic().then(
              (value) {
                Navigator.pushNamed(context, _buttonRoutes[index]);
                _controllers[index].reverse();
              },
            );
            Navigator.pushNamed(context, _buttonRoutes[index]);
            _controllers[index].reverse();
          } else {
            Navigator.pushNamed(context, _buttonRoutes[index]);
            _controllers[index].reverse();
          }
        },
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
                  style: Theme.of(context).textTheme.headline4.copyWith(
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
