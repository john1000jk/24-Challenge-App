import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import './numbers.dart';
import './csv_reader.dart';
import 'dart:math';

class Normal extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    int comboIndex = Random().nextInt(Database.getCombos().length);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Normal Screen'),
      ),
      body: Numbers(Database.getCombos().elementAt(comboIndex), comboIndex),
    );
  }
}