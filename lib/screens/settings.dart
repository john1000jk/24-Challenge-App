import 'package:flutter/material.dart';

import '../audio_player.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SettingsState();
  }
}

class _SettingsState extends State<Settings> {
  bool musicOn = AudioP.canPlay;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SizedBox(
        width: width,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 250,
              height: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: FittedBox(
                      child: Text(
                        'Music',
                        style: Theme.of(context).textTheme.displayMedium!,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5),
                    width: 100,
                    height: 100,
                    child: FittedBox(
                      child: Switch(
                        activeThumbColor: Colors.green,
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