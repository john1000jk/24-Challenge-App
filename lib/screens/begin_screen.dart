import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twenty_four_game/audio_player.dart';

class BeginScreen extends StatelessWidget {
  final String _route;
  BeginScreen(this._route);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Center(
            child: Container(
              width: _width/2,
              height: _height/8,
              padding: EdgeInsets.all(10),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                color: Colors.lightBlueAccent,
                onPressed: () async {
                  await AudioP.loadMusic().then((value) {
                    Navigator.pushReplacementNamed(context, _route);
                  });
                },
                child: ConstrainedBox(
                  constraints: BoxConstraints.expand(),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Begin"),
                            SizedBox(width: 3),
                            Icon(Icons.timer, size: 20),
                          ],
                        ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
