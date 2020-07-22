import 'dart:math';

import 'package:flutter/material.dart';
import 'package:twenty_four_game/begin_screen.dart';
import 'package:twenty_four_game/staggered_numbers.dart';
import 'package:twenty_four_game/themes/styles.dart';
import './home.dart';
import './time_trial.dart';
import './normal.dart';
import 'csv_reader.dart';

class TimeTrial extends StatelessWidget {
  final int comboIndex = Random().nextInt(Database.getCombos().length);

  @override
  Widget build(BuildContext context) {
    Database.resetValues();
    return Scaffold(
      backgroundColor: AppTheme().accentColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (StaggeredNumbersState.current >= 1) {
              Navigator.of(context).pop();
            }
          }
        ),
        title: Text(
            'Time Trial Screen'),
      ),
      body: StaggeredNumbers(Database.getCombos().elementAt(comboIndex), comboIndex),
    );
  }

}