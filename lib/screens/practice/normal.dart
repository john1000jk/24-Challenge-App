import 'package:flutter/material.dart';
import 'package:twenty_four_game/themes/styles.dart';
import 'numbers.dart';
import '../../csv_reader.dart';
import 'dart:math';

class Normal extends StatelessWidget {
  const Normal({super.key});

  @override
  Widget build(BuildContext context) {
    Database.resetValues();
    int comboIndex = Random().nextInt(Database.getCombos().length);
    return Scaffold(
      backgroundColor: accentColor,
      appBar: AppBar(
        title: Text('Normal Screen'),
      ),
      body: Numbers(Database.getCombos().elementAt(comboIndex), comboIndex),
    );
  }
}