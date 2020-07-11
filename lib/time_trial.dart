import 'package:flutter/material.dart';
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
    );
  }

}