import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BeginScreen extends StatefulWidget {
  final String route;
  BeginScreen(this.route);

  @override
  _BeginState createState() => _BeginState();
}

class _BeginState extends State<BeginScreen> with TickerProviderStateMixin {

  bool reveal = true;
  bool done = false;

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
                onPressed: () {
                  reveal = true;
                  Navigator.pushReplacementNamed(context, widget.route);
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
