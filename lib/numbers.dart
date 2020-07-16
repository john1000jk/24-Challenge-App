import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twenty_four_game/staggered_numbers.dart';
import './csv_reader.dart';
import './normal.dart';
import 'package:auto_size_text/auto_size_text.dart';
import './num_button.dart';
import './op_button.dart';
import './operation.dart';

class Numbers extends StatefulWidget {
  final List<double> _numList;
  final int comboIndex;
  final String route = '/normal';

  List<double> get numList => _numList;

  changeNumList(int index, double value) {
    _numList[index] = value;
  }

  Numbers(this._numList, this.comboIndex);

  @override
  State<StatefulWidget> createState() {
    return NumbersState();
  }
}

class NumbersState extends State<Numbers> {
  List<bool> _isSelected = [false, false, false, false];
  List<bool> _opSelected = [false, false, false, false];
  List<bool> _disabledButtons = [false, false, false, false];
  List<Operation> _previousOperations = [];
  int comboIndexS;

  List<Operation> get previousOperations => _previousOperations;

  void addOperation(Operation o) {
    _previousOperations.add(o);
  }

  void removeOperation() {
    _previousOperations.removeLast();
  }

  List _operators = [
    Icon(Icons.add),
    Icon(Icons.remove),
    Icon(Icons.close),
    Image.asset("assets/division.png")
  ];

  List<Color> _opColors = [
    Color.fromRGBO(255, 206, 186, 1.0),
    Color.fromRGBO(255, 226, 173, 1.0),
    Color.fromRGBO(176, 255, 226, 1.0),
    Color.fromRGBO(206, 199, 255, 1.0)
  ];

  List<Color> get opColors => _opColors;

  List get operators => _operators;

  List<bool> get disabledButtons => _disabledButtons;

  void changeDisabledButtons(int index, bool value) {
    _disabledButtons[index] = value;
  }

  List<bool> get isSelected => _isSelected;

  void changeSelected(int index, bool value) {
    _isSelected[index] = value;
  }

  List<bool> get opSelected => _opSelected;

  void changeOPSelected(int index, bool value) {
    _opSelected[index] = value;
  }

  @override
  void initState() {
    super.initState();
    comboIndexS = widget.comboIndex;
  }

  void reverseOperation(Operation o) {
    double value;
    switch (o.opIndex) {
      case 0:
        value = widget.numList[o.changedIndex] - widget.numList[o.operandIndex];
        break;
      case 1:
        value = -1 * widget.numList[o.changedIndex] +
            widget.numList[o.operandIndex];
        break;
      case 2:
        value = widget.numList[o.changedIndex] / widget.numList[o.operandIndex];
        break;
      case 3:
        value = 1 /
            widget.numList[o.changedIndex] * //Need to check for 0 later
            widget.numList[o.operandIndex];
        if ((value.round() - value).abs() < .001) {
          value = value.round().toDouble();
        }
        break;
    }

    removeOperation();
    for (int i = 0; i < isSelected.length; i++) {
      changeSelected(i, false);
    }
    changeSelected(o.operandIndex, true);
    disabledButtons[o.operandIndex] = false;
    widget.changeNumList(o.changedIndex, value);
  }

  reset() {
    setState(() {
      Database.resetValues();
      _isSelected = [false, false, false, false];
      _opSelected = [false, false, false, false];
      _disabledButtons = [false, false, false, false];
      _previousOperations = [];
      comboIndexS = Random().nextInt(Database.getCombos().length);
      for (int i = 0; i < Database.getCombos().elementAt(comboIndexS).length; i++) {
        widget.changeNumList(i, Database.getCombos().elementAt(comboIndexS).elementAt(i));
      }
    });
  }

  createDialog(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    String enterSepSols = '';
    String enterSepSols2 = '';
    for (int i = 0;
        i < Database.getSolutions().elementAt(comboIndexS).length;
        i++) {
      if (i < 6) {
        enterSepSols += (i + 1).toString() + ":  ";
        enterSepSols += Database.getSolutions().elementAt(comboIndexS)[i];
        if (i != 5 &&
            i !=
                Database.getSolutions().elementAt(comboIndexS).length -
                    1) {
          enterSepSols += '\n';
        }
      } else {
        enterSepSols2 += (i + 1).toString() + ":  ";
        enterSepSols2 +=
            Database.getSolutions().elementAt(comboIndexS)[i];
        if (i !=
            Database.getSolutions().elementAt(comboIndexS).length - 1) {
          enterSepSols2 += '\n';
        }
      }
    }

    return showDialog(
        context: context,
        builder: (context) {
          return GestureDetector(
            onTap: () {
              reset();
              Navigator.pop(context);
            },
            child: AlertDialog(
                title: FittedBox(
                  child: Center(
                      child: Text(
                    "Solutions:",
                        style: TextStyle(fontWeight: FontWeight.normal),
                  )),
                ),
                content: FittedBox(
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 300,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                child: Text(
                                  enterSepSols,
                                  style: (enterSepSols2.length == 0)
                                      ? TextStyle(fontSize: 35, height: 1.5)
                                      : TextStyle(fontSize: 20, height: 1.5),
                                ),
                              ),
                            ),
                            (enterSepSols2.length != 0)
                                ? Column(
                              children: <Widget>[
                                    (enterSepSols2.length != 0)
                                    ? Container(
                                        child: Text(
                                        enterSepSols2,
                                        style: TextStyle(fontSize: 20, height: 1.5),
                                      ))
                                    : Container(),
                                  ],
                            ) : Container(),
                          ],
                        ),
                      ),
                      FittedBox(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Container(
                            width: 300,
                            child: Center(
                              child: Text(
                                'Click Anywhere to Continue',
                                style:
                                    TextStyle(fontSize: 20, color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )),
          );
        }).then((result) {
      reset();
    });
  }

  Function undoFunction() {
    if (previousOperations.isEmpty) {
      return null;
    } else {
      return () => setState(() => reverseOperation(
          previousOperations.elementAt(previousOperations.length - 1)));
    }
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Container(
      width: _width,
      height: _height-80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: _width/2,
            child: Row(
              children: <Widget>[
                Expanded(child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 20.0, bottom: 5.0, right: 5.0),
                  child: NumButton(0, this),
                )),
                Expanded(child: Padding(
                  padding: const EdgeInsets.only(left: 5.0, top: 20.0, bottom: 5.0, right: 20.0),
                  child: NumButton(1, this),
                )),
              ],
            ),
          ),
          Container(
            height: _width/2,
            child: Row(
              children: <Widget>[
                Expanded(child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 5.0, bottom: 20.0, right: 5.0),
                  child: NumButton(2, this),
                )),
                Expanded(child: Padding(
                  padding: const EdgeInsets.only(left: 5.0, top: 5.0, bottom: 20.0, right: 20.0),
                  child: NumButton(3, this),
                )),
              ],
            ),
          ),
          Container(
            height: (_height-80-_width)/2,
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Row(
                children: <Widget>[
                  Expanded(child: OpButton(0, this)),
                  Expanded(child: OpButton(1, this)),
                  Expanded(child: OpButton(2, this)),
                  Expanded(child: OpButton(3, this)),
                ],
              ),
            ),
          ),
          Container(
            height: (_height-80-_width)/2,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0, left: 10.0),
                    child: SizedBox.expand(
                      child: FlatButton(
                          onPressed: undoFunction(),
                          child: FittedBox(
                            child: Text(
                              "UNDO",
                              style: TextStyle(fontSize: 500, fontWeight: FontWeight.normal),
                            ),
                          )),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0, right: 10.0),
                    child: SizedBox.expand(
                      child: FlatButton(
                          onPressed: () {
                            createDialog(context);
                          },
                          child: FittedBox(
                            child: Text(
                              "SKIP",
                              style: TextStyle(fontSize: 500, fontWeight: FontWeight.normal),
                            ),
                          )),
                    ),
                  ),
                ),              ],
            ),
          )
        ],
      ),
    );

  }
}