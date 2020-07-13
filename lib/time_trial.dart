import 'package:flutter/material.dart';
import 'package:twenty_four_game/begin_screen.dart';
import './home.dart';
import './time_trial.dart';
import './normal.dart';

class TimeTrial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Time Trial Screen'),
      ),
      body: Container(),
    );
  }

}