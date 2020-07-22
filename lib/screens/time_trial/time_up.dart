import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';

import '../../csv_reader.dart';
import 'package:flutter/material.dart';
import 'package:twenty_four_game/screens/time_trial/staggered_numbers.dart';
import 'package:confetti/confetti.dart';

class AnimationStation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AnimationStationState();
  }
}

class AnimationStationState extends State<AnimationStation>
    with TickerProviderStateMixin {
  ConfettiController _controller;
  AnimationController _animationController;
  bool _isAnimDisposed = false;
  Animation<double> animation;

  @override
  void initState() {
    _controller =
        ConfettiController(duration: const Duration(milliseconds: 100));
    super.initState();
    _controller.play();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );
    _playAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    _isAnimDisposed = true;
    super.dispose();
  }

  Future<void> _playAnimation() async {
    try {
      await Future.delayed(Duration(milliseconds: 1000), () {
        if (!_isAnimDisposed) {
          _animationController.forward();
        } else {
          _isAnimDisposed = false;
        }
      });
    } on Exception {
      print('Canceled');
    }
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    timeDilation = 1.0;
    return Scaffold(
      appBar: AppBar(
        title: Text('Finished'),
      ),
      body: Container(
        width: _width,
        height: _height * .8,
        child: Column(
          children: <Widget>[
            Container(
              width: _width,
              height: _height * .001,
              child: Align(
                alignment: Alignment.center,
                child: ConfettiWidget(
                  confettiController: _controller,
                  numberOfParticles: 30,
                  blastDirectionality: BlastDirectionality.explosive,
                  shouldLoop: false,
                  colors: const [
                    Colors.green,
                    Colors.orange,
                    Colors.blue,
                  ],
                ),
              ),
            ),
            Container(
              width: _width,
              height: _height * .2,
              child: FittedBox(
                child: Padding(
                  padding: EdgeInsets.only(right: 20.0, left: 20.0),
                  child: Text(
                    'Your time is UP!\nFinal Score: ${StaggeredNumbersState.numCorrect}',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
              ),
            ),
            Container(
              width: _width,
              height: _height * .4,
              child: MultiAnimation(
                controller: _animationController.view,
              ),
            ),
            Container(
              width: _width,
              height: _height * .15,
              child: Row(
                children: <Widget>[
                  Spacer(),
                  FittedBox(
                    child: IconButton(
                      icon: Icon(Icons.question_answer),
                      iconSize: 70,
                      onPressed: () =>
                          Navigator.pushNamed(context, '/previous_q'),
                      tooltip: 'Past Questions',
                    ),
                  ),
                  Spacer(),
                  FittedBox(
                    child: IconButton(
                      icon: Icon(Icons.replay),
                      iconSize: 70,
                      onPressed: () => Navigator.pushReplacementNamed(
                          context, '/begin_screen1'),
                    ),
                  ),
                  Spacer(),
                  FittedBox(
                    child: IconButton(
                      icon: Icon(Icons.thumb_up),
                      iconSize: 70,
                      onPressed: null,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            Expanded(
              child: Container(),
            )
          ],
        ),
      ),
    );
  }
}

class MultiAnimation extends StatelessWidget {
  MultiAnimation({Key key, this.controller})
      : opacity = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.0,
              1.0,
              curve: Curves.linear,
            ),
          ),
        ),
        translateX = TweenSequence<double>(<TweenSequenceItem<double>>[
          TweenSequenceItem<double>(
            tween: Tween<double>(
              begin: 50,
              end: 3500,
            ),
            weight: 40,
          ),
          TweenSequenceItem<double>(
            tween: Tween<double>(
              begin: 400,
              end: -3500,
            ),
            weight: 25.0,
          ),
          TweenSequenceItem<double>(
            tween: Tween<double>(
              begin: 0,
              end: 2000,
            ),
            weight: 25.0,
          ),
          TweenSequenceItem<double>(
            tween: Tween<double>(
              begin: -2000,
              end: 50,
            ),
            weight: 10.0,
          ),
        ]).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              .05,
              .5 + Random().nextDouble() * .5,
              curve: Curves.linear,
            ),
          ),
        ),
        translateY = TweenSequence<double>(<TweenSequenceItem<double>>[
          TweenSequenceItem<double>(
              tween: Tween<double>(
                begin: 100.0,
                end: -3000.0,
              ),
              weight: 40.0),
          TweenSequenceItem<double>(
            tween: Tween<double>(
              begin: -200,
              end: 4000.0,
            ),
            weight: 20.0,
          ),
          TweenSequenceItem<double>(
            tween: Tween<double>(
              begin: -900.0,
              end: 3750.0,
            ),
            weight: 25.0,
          ),
          TweenSequenceItem<double>(
            tween: Tween<double>(
              begin: 1000.0,
              end: 0,
            ),
            weight: 15.0,
          ),
        ]).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              .05,
              .5 + Random().nextDouble() * .5,
              curve: Curves.linear,
            ),
          ),
        ),
        scale = Tween<double>(
          begin: 1.0,
          end: 5.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.0,
              1.0,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        super(key: key);

  final Animation<double> controller;
  final Animation<double> opacity;
  final Animation<double> translateX;
  final Animation<double> translateY;
  final Animation<double> scale;

  @override
  Widget _buildAnim(BuildContext context, Widget child) {
    return Container(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 2500),
        child: Opacity(
          opacity: opacity.value,
          child: Text(
            '24!',
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        transform:
            Matrix4.translationValues(translateX.value, translateY.value, 0)
              ..scale(scale.value),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AnimatedBuilder(
      builder: _buildAnim,
      animation: controller,
    );
  }
}

class AnsweredQuestions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(StaggeredNumbersState.problemIndices);
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Previous Questions'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: _width,
            height: _height * .11,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black12,
                  width: 1.0,
                ),
              ),
              shape: BoxShape.rectangle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: FittedBox(
                child: Text(
                  'Problems Encountered Last Round',
                  style: Theme.of(context).textTheme.headline4,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Container(
            width: _width,
            height: _height * .65,
            child: ListView.separated(
              itemCount: StaggeredNumbersState.problemIndices.length + 1,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: _height * .1,
                  child: ListView.separated(
                    padding: const EdgeInsets.all(8),
                    scrollDirection: Axis.horizontal,
                    itemCount: (index == 0)
                        ? 3
                        : Database.getSolutions()
                                .elementAt(StaggeredNumbersState
                                    .problemIndices[index - 1])
                                .length +
                            2,
                    itemBuilder: (BuildContext context, int index2) {
                      return Container(
                        width: (index2 == 0) ? _width / 6.5 : _width*.4,
                        child: Center(
                          child: (index == 0 && index2 == 0)
                              ? Icon(
                                  Icons.toys,
                                  size: 40,
                                )
                              : (index == 0 && index2 == 1)
                                  ? Text('Numbers',
                                      style: TextStyle(fontSize: 25))
                                  : (index == 0 && index2 == 2)
                                      ? Text('Solutions',
                                          style: TextStyle(fontSize: 25))
                                      : (index2 == 0)
                                          ? Text('#$index',
                                              style: TextStyle(fontSize: 23))
                                          : (index2 == 1)
                                              ? Text(
                                                  '${Database.writCombos().elementAt(StaggeredNumbersState.problemIndices[index - 1])}',
                                                  style:
                                                      TextStyle(fontSize: 21.5),
                                                )
                                              : Text(
                                                  '${Database.getSolutions().elementAt(StaggeredNumbersState.problemIndices[index - 1]).elementAt(index2 - 2)}',
                                                  style:
                                                      TextStyle(fontSize: 21.5)),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider();
                    },
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.black12,
                  width: 1.0,
                ),
              ),
              shape: BoxShape.rectangle,
            ),
            height: _height * .13,
            width: _width,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 0, right: 0, bottom: 10.0),
              child: FittedBox(
                  child: Text(
                'Scroll down for more questions\nScroll right for more solutions\n*Note: Some only have one solution',
                style: TextStyle(height: 1.5, fontSize: 40),
                textAlign: TextAlign.center,
              )),
            ),
          ),
        ],
      ),
    );
  }
}
