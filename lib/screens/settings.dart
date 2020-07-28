import 'package:flutter/material.dart';

import '../audio_player.dart';

class Settings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SettingsState();
  }
}

class _SettingsState extends State<Settings> {
  bool musicOn = AudioP.canPlay;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: _width,
        height: _height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 250,
              height: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 150,
                    height: 150,
                    child: FittedBox(
                      child: Text(
                        'Music',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5),
                    width: 100,
                    height: 100,
                    child: FittedBox(
                      child: Switch(
                        activeColor: Colors.green,
                        value: musicOn,
                        onChanged: (value) {
                          setState(() {
                            musicOn = value;
                            AudioP.canPlay = value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}