import 'package:flutter/material.dart';
import 'package:twenty_four_game/audio_player.dart';

class BeginScreen extends StatelessWidget {
  final String _route;
  const BeginScreen(this._route, {super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Center(
            child: Container(
              width: width/2,
              height: height/8,
              padding: EdgeInsets.all(10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlueAccent,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                onPressed: () async {
                  await AudioP.loadMusic();
                  if (!context.mounted) return;
                  Navigator.pushReplacementNamed(context, _route);
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
