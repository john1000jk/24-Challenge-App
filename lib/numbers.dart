import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './home.dart';
import './csv_reader.dart';
import './normal.dart';
import 'package:auto_size_text/auto_size_text.dart';
import './num_button.dart';
import './op_button.dart';

class Numbers extends StatefulWidget {
  final List<double> _numList;
  final int comboIndex;

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

//  List<Color> _opColors = [Color.fromRGBO(127, 247, 255, 1.0)];

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
    disabledButtons[o.operandIndex] = false;
    widget.changeNumList(o.changedIndex, value);
  }

  createDialog(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    String enterSepSols = '';
    for (int i = 0;
    i < Database.getSolutions().elementAt(widget.comboIndex).length;
    i++) {
      enterSepSols += (i + 1).toString() + ":  ";
      enterSepSols += Database.getSolutions().elementAt(widget.comboIndex)[i];
      if (i !=
          Database.getSolutions().elementAt(widget.comboIndex).length - 1) {
        enterSepSols += '\n';
      }
    }

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: FittedBox(
              child: Center(
                  child: Text(
                    "Solutions:",
                    style: Theme.of(context).textTheme.headline1,
                  )),
            ),
            content: FittedBox(
              child: Text(
                enterSepSols,
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            actions: <Widget>[
              RaisedButton(
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) => Normal(),
                      transitionDuration: Duration(seconds: 0),
                    ),
                  );
                },
                child: Container(
                  width: _width/4,
                  height: _height/12,
                  child: FittedBox(
                    child: AutoSizeText(
                      "NEXT",
                      minFontSize: 15,
                      maxFontSize: 50,
                      maxLines: 1,
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }

//  update() {
//    int comboIndex2 = Random().nextInt(Database.getCombos().length);
//    return Numbers(Database.getCombos().elementAt(comboIndex2), comboIndex2);
//  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    Function undoFunction() {
      if (previousOperations.isEmpty) {
        return null;
      } else {
        return () => setState(() => reverseOperation(
            previousOperations.elementAt(previousOperations.length - 1)));
      }
    }

    return GridView.count(
        primary: false,
        childAspectRatio: 1.0,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 1.5,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: <Widget>[
          NumButton(0, this),
          NumButton(1, this),
          NumButton(2, this),
          NumButton(3, this),
          Column(
            children: <Widget>[
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    OpButton(0, this),
                    Spacer(),
                    OpButton(1, this),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    child: ConstrainedBox(
                      constraints: BoxConstraints.expand(),
                      child: FlatButton(
                          onPressed: undoFunction(),
                          child: FittedBox(
                            child: Text(
                              "UNDO",
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          )),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    OpButton(2, this),
                    Spacer(),
                    OpButton(3, this),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    child: ConstrainedBox(
                      constraints: BoxConstraints.expand(),
                      child: FlatButton(
                          onPressed: () => createDialog(context),
                          child: FittedBox(
                            child: Text(
                              "SKIP",
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          )),
                    ),
                  ),
                ),
              ),
            ],
          )
        ]);
  }
}

class Operation {
  int _changedIndex;
  int _opIndex;
  int _operandIndex;

  Operation(this._changedIndex, this._opIndex, this._operandIndex);

  int get changedIndex => _changedIndex;

  int get operandIndex => _operandIndex;

  int get opIndex => _opIndex;
}
