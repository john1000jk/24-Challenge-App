import 'package:flutter/material.dart';
import './main.dart';
import './csv_reader.dart';

class Home extends StatelessWidget {
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Spacer(),
          RaisedButton(
            textColor: Colors.white,
            padding: const EdgeInsets.all(0.0),
            onPressed: () {
              Navigator.pushNamed(context, '/time_trial');
            },
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    Color(0xFF0D47A1),
                    Color(0xFF1976D2),
                    Color(0xFF42A5F5),
                  ],
                ),
              ),
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: _width - 60,
                height: _height/7,
                child: FittedBox (
                  fit: BoxFit.contain,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0, right: 2.0, bottom: 2.0),
                        child: Icon(
                          Icons.timer,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.5),
                        child: Text(
                          "Time Trial",
                          style: TextStyle(
                            fontFamily: 'Romanica',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Spacer(),
          RaisedButton(
            textColor: Colors.white,
            padding: const EdgeInsets.all(0.0),
            onPressed: () {
              Navigator.pushNamed(context, '/normal');
            },
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: <Color>[
                    Color(0xFF0D47A1),
                    Color(0xFF1976D2),
                    Color(0xFF42A5F5),
                  ],
                ),
              ),
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: _width - 60,
                height: _height/7,
                child: FittedBox (
                  fit: BoxFit.contain,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0, right: 2.0, bottom: 2.0),
                        child: Icon(
                          Icons.border_all,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.5),
                        child: Text(
                          "Normal Mode",
                          style: TextStyle(
                            fontFamily: 'Romanica',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Spacer(flex: 2),
        ],
      ),
    );
  }
}
