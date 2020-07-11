import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import './numbers.dart';
import './csv_reader.dart';
import 'dart:math';

class Normal extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _NormalState();
  }

}

class _NormalState extends State<Normal> {
  @override
  Widget build(BuildContext context) {
    int comboIndex = Random().nextInt(Database.getCombos().length);
    return Scaffold(
      appBar: AppBar(
        title: Text('Normal Screen'),
      ),
      body: Numbers(Database.getCombos().elementAt(comboIndex), comboIndex),
    );
  }
}