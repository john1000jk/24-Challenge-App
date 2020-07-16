import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './numbers.dart';
import './num_button.dart';
import './op_button.dart';
import './operation.dart';
import 'package:quiver/async.dart';

class StaggeredNumbers extends Numbers {
  StaggeredNumbers(List<double> numList, int comboIndex)
      : super(numList, comboIndex);

  final route = '/time_trial';

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StaggeredNumbersState();
  }
}

class StaggeredNumbersState extends NumbersState {
  static int numCorrect = 0;
  static int current = 120;
  Timer countdownTimer;
  bool timerDone = false;

  void startTimer() {
    countdownTimer = Timer.periodic(
      Duration(seconds: 1),
        (timer) {
      setState(() {
        if (current > 0) {
          current --;
        } else {
          timerDone = true;
          countdownTimer.cancel();
          Navigator.pushReplacementNamed(context, '/begin_screen1');
        }
      });
    });
  }

  @override
  reset() {
    super.reset();
    if (timerDone) {
      startTimer();
      timerDone = false;
    }
  }

  @override
  createDialog(BuildContext context) {
    countdownTimer.cancel();
    timerDone = true;
    return super.createDialog(context);
  }

  @override
  void initState() {
    super.initState();
    numCorrect = 0;
    current = 120;
    startTimer();
  }

  @override
  void dispose() {
    timerDone = true;
    countdownTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Container(
      height: _height - 80,
      width: _width,
      child: Column(
        children: <Widget>[
          Container(
            height: (_height - 80) / 8,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 0.0, top: 10.0, bottom: 10.0, right: 0.0),
                    child: FittedBox(child: Icon(Icons.timer)),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10.0, right: 30.0),
                    child: FittedBox(
                        child: Center(
                            child:
                                !(current < 1) ? Text('$current') : Text('0'))),
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: FittedBox(child: Icon(Icons.star)),
                )),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 30.0),
                    child: FittedBox(
                        child: Text('${StaggeredNumbersState.numCorrect}')),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: _width * .45,
            width: _width * .9,
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
                  child: NumButton(0, this),
                )),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                  child: NumButton(1, this),
                )),
              ],
            ),
          ),
          Container(
            height: _width * .45,
            width: _width * .9,
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(right: 8.0, top: 8.0),
                  child: NumButton(2, this),
                )),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                  child: NumButton(3, this),
                )),
              ],
            ),
          ),
          Container(
            height: (_height - 80 - (_height - 80) / 8 - _width * .9) / 2,
            width: _width * .9,
            child: Row(
              children: <Widget>[
                Expanded(child: FittedBox(child: OpButton(0, this))),
                Expanded(child: FittedBox(child: OpButton(1, this))),
                Expanded(child: FittedBox(child: OpButton(2, this))),
                Expanded(child: FittedBox(child: OpButton(3, this))),
              ],
            ),
          ),
          Container(
            height: (_height - 80 - (_height - 80) / 8 - _width * .9) / 2,
            width: _width * .9,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0, left: 10.0),
                    child: SizedBox.expand(
                      child: FlatButton(
                          onPressed: undoFunction(),
                          child: FittedBox(
                            child: Text(
                              "UNDO",
                              style: TextStyle(
                                  fontSize: 500, fontWeight: FontWeight.normal),
                            ),
                          )),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0, right: 10.0),
                    child: SizedBox.expand(
                      child: FlatButton(
                          onPressed: () {
                            createDialog(context);
                            StaggeredNumbersState.current -= 30;
                          },
                          child: FittedBox(
                            child: Text(
                              "SKIP",
                              style: TextStyle(
                                  fontSize: 500, fontWeight: FontWeight.normal),
                            ),
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    // TODO: implement build
  }
}
