import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twenty_four_game/screens/practice/numbers.dart';
import '../../buttons/num_button.dart';
import '../../buttons/op_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  static List<int> problemIndices = [];
  int _highScore = 0;
  Timer _countdownTimer;
  bool _timerDone = false;

  void startTimer() {
    _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (current > 0) {
          current--;
        } else {
          _timerDone = true;
          _countdownTimer.cancel();
          Navigator.pushReplacementNamed(context, '/time_up');
        }
      });
    });
  }

  @override
  reset() {
    super.reset();
    problemIndices.add(comboIndexS);
    if (_timerDone) {
      startTimer();
      _timerDone = false;
    }
  }

  @override
  createDialog(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _countdownTimer.cancel();
    _timerDone = true;
    super.createDialog(context);
    _highScore = max(preferences.getInt('highScore') ?? 0, numCorrect);
    preferences.setInt('highScore', _highScore);
  }

  @override
  void initState() {
    super.initState();
    problemIndices = [];
    problemIndices.add(comboIndexS);
    _loadHighScore();
    numCorrect = 0;
    current = 120;
    startTimer();
  }

  _loadHighScore() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      _highScore = (preferences.getInt('highScore') ?? 0);
    });
  }

  @override
  void dispose() {
    _timerDone = true;
    _countdownTimer.cancel();
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
                Container(
                  width: _width/40,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 0.0, top: 10.0, bottom: 10.0, right: 5.0),
                    child: FittedBox(child: Icon(Icons.timer)),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10.0, left: 0.0),
                    child: FittedBox(
                        child: Center(
                            child:
                                !(current < 1) ? Text('$current') : Text('0'))),
                  ),
                ),
                SizedBox(
                  width: _width/20,
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 0.0, bottom: 5.0, top: 5.0),
                  child: FittedBox(child: Icon(Icons.star)),
                )),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 0.0),
                    child: FittedBox(
                        child: Text('${StaggeredNumbersState.numCorrect}')),
                  ),
                ),
                SizedBox(
                  width: _width/20,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0.0, bottom: 0.0, right: 5.0),
                    child: FittedBox(child: Icon(Icons.local_convenience_store)),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: FittedBox(
                        child: Text('$_highScore')),
                  ),
                ),
                SizedBox(
                  width: _width/20,
                ),
              ],
            ),
          ),
          Container(
            height: _width * .45,
            width: _width * .9,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
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
          ),
          Container(
            height: _width * .45,
            width: _width * .9,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
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
                                  fontSize: 55, fontWeight: FontWeight.normal),
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
                            if (current >= 1) {
                              createDialog(context);
                              StaggeredNumbersState.current -= 30;
                            }
                          },
                          child: FittedBox(
                            child: Text(
                              "SKIP",
                              style: TextStyle(
                                  fontSize: 55, fontWeight: FontWeight.normal),
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
  }
}
