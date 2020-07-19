import 'dart:math';

import 'package:flutter/material.dart';
import 'package:twenty_four_game/begin_screen.dart';
import 'package:twenty_four_game/staggered_numbers.dart';
import './home.dart';
import './time_trial.dart';
import './normal.dart';
import 'csv_reader.dart';

class TimeTrial extends StatelessWidget {
  int comboIndex = Random().nextInt(Database.getCombos().length);

  @override
  Widget build(BuildContext context) {
    Database.resetValues();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
            'Time Trial Screen'),
      ),
      body: StaggeredNumbers(Database.getCombos().elementAt(comboIndex), comboIndex),
    );
  }

}