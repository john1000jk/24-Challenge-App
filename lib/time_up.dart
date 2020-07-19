import 'dart:math';

import 'package:flutter/scheduler.dart';

import './csv_reader.dart';
import 'package:flutter/material.dart';
import 'package:twenty_four_game/staggered_numbers.dart';
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
    super.dispose();
  }

  Future<void> _playAnimation() async {
    try {
      await Future.delayed(Duration(milliseconds: 1000), () {
        _animationController.forward().orCancel;
      });
    } on TickerCanceled {
      // the animation got canceled, probably because we were disposed
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
              height: _height * .025,
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
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Your time is UP!\nFinal Score: ${StaggeredNumbersState.numCorrect}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 50,
                      fontFamily: 'Romanica',
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: _width,
              height: _height*.4,
              child: MultiAnimation(
                controller: _animationController.view,
              ),
            ),
            Container(
              width: _width,
              height: _height*.15,
              child: Row(
                children: <Widget>[
                  Spacer(),
                  FittedBox(
                    child: IconButton(
                      icon: Icon(Icons.grid_on),
                      iconSize: 70,
                      onPressed: () => Navigator.pushNamed(context, '/previous_q'),
                      tooltip: 'Past Questions',
                    ),
                  ),
                  Spacer(),
                  FittedBox(
                    child: IconButton(
                      icon: Icon(Icons.replay),
                      iconSize: 70,
                      onPressed: () => Navigator.pushReplacementNamed(context, '/begin_screen1'),
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
              end:3500,
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
              end: 70,
            ),
            weight: 10.0,
          ),
        ]).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              .05,
              .5 + Random().nextDouble()*.5,
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
                .5 + Random().nextDouble()*.5,
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
            style: TextStyle(
                  fontSize: 40, fontFamily: 'Cardo'),
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

class AnsweredQuestions extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Previous Questions'),
      ),
      body: Container(
        width: _width*.9,
        height: _height * .8,
        child: ListView.separated(
          padding: const EdgeInsets.all(8.0),
          itemCount: StaggeredNumbersState.problemIndices.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: _height * 1.8,
              child: ListView.separated(
                padding: const EdgeInsets.all(8),
                scrollDirection: Axis.horizontal,
                itemCount: Database.getSolutions()
                    .elementAt(
                    StaggeredNumbersState.problemIndices[index])
                    .length + 2,
                itemBuilder: (BuildContext context, int index2) {
                  return Container(
                    width: _width/3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                        child: (index2 == 0)
                            ? Text('Problem $index')
                            : (index2 == 1)
                            ? Text(
                            '${Database.writCombos().elementAt(StaggeredNumbersState.problemIndices[index])}')
                            : Text(
                            '${Database.getSolutions().elementAt(StaggeredNumbersState.problemIndices[index]).elementAt(index2-2)}',
                            style: TextStyle(fontSize: 80)),
                      ),
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
    );
  }
}

