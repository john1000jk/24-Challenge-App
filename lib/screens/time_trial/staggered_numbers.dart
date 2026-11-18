import 'dart:async';

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:twenty_four_game/audio_player.dart';
import 'package:twenty_four_game/screens/practice/numbers.dart';
import 'package:twenty_four_game/services/high_score.dart';
import '../../buttons/num_button.dart';
import '../../buttons/op_button.dart';

class StaggeredNumbers extends Numbers {
  const StaggeredNumbers(super.numList, super.comboIndex, {super.key});

  @override
  String get route => '/time_trial';

  @override
  State<StatefulWidget> createState() {
    return StaggeredNumbersState();
  }
}

class StaggeredNumbersState extends NumbersState {
  static int numCorrect = 0;
  static int current = 120;
  static List<int> problemIndices = [];
  int _highScore = 0;
  Timer? _countdownTimer;
  bool _timerDone = false;

  void startTimer() {
    _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (current > 0) {
          current--;
        } else {
          _timerDone = true;
          timer.cancel();
          Navigator.pushReplacementNamed(context, '/time_up');
        }
      });
    });
  }

  @override
  void reset() {
    super.reset();
    problemIndices.add(comboIndexS);
    if (_timerDone) {
      startTimer();
      _timerDone = false;
    }
  }

  @override
  Future<void> createDialog(BuildContext context) async {
    _countdownTimer?.cancel();
    _timerDone = true;
    await super.createDialog(context);
  }

  @override
  void initState() {
    super.initState();
    problemIndices = [];
    problemIndices.add(comboIndexS);
    numCorrect = 0;
    current = 120;
    _loadHighScore();
    startTimer();
  }

  Future<void> _loadHighScore() async {
    final best = await HighScore.load();
    if (mounted) setState(() => _highScore = best);
  }

  @override
  void dispose() {
    _timerDone = true;
    AudioP.stop();
    _countdownTimer?.cancel();
    // The round is over (time ran out or the player left): record the score.
    HighScore.submit(numCorrect);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Builder(
      builder: (context) {
        return SizedBox(
          height: height - 80,
          width: width,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: (height - 80) / 8,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: width / 40,
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
                      width: width / 20,
                    ),
                    Expanded(
                        child: Padding(
                      padding:
                          const EdgeInsets.only(left: 0.0, bottom: 5.0, top: 5.0),
                      child: FittedBox(child: Icon(Icons.star)),
                    )),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, bottom: 10.0, right: 0.0),
                        child: FittedBox(
                            child: Text('${StaggeredNumbersState.numCorrect}')),
                      ),
                    ),
                    SizedBox(
                      width: width / 20,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 0.0, bottom: 0.0, right: 5.0),
                        child:
                            FittedBox(child: Icon(Icons.local_convenience_store)),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: FittedBox(child: Text('${max(_highScore, numCorrect)}')),
                      ),
                    ),
                    SizedBox(
                      width: width / 20,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: width * .45,
                width: width * .9,
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
              SizedBox(
                height: width * .45,
                width: width * .9,
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
              SizedBox(
                height: (height - 85 - (height - 80) / 8 - width * .9) / 2,
                width: width * .9,
                child: Row(
                  children: <Widget>[
                    Expanded(child: FittedBox(child: OpButton(0, this))),
                    Expanded(child: FittedBox(child: OpButton(1, this))),
                    Expanded(child: FittedBox(child: OpButton(2, this))),
                    Expanded(child: FittedBox(child: OpButton(3, this))),
                  ],
                ),
              ),
              SizedBox(
                height: (height - 85 - (height - 80) / 8 - width * .9) / 2,
                width: width * .9,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10.0, left: 10.0),
                        child: SizedBox.expand(
                          child: MaterialButton(
                              elevation: 0,
                              enableFeedback: false,
                              onPressed: undoFunction(),
                              child: FittedBox(
                                child: Text(
                                  "UNDO",
                                  style: TextStyle(
                                      fontSize: 45, fontWeight: FontWeight.normal),
                                ),
                              )),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10.0, right: 10.0),
                        child: SizedBox.expand(
                          child: MaterialButton(
                              elevation: 0,
                              enableFeedback: false,
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
                                      fontSize: 45, fontWeight: FontWeight.normal),
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
    );
  }
}
