import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twenty_four_game/staggered_numbers.dart';
import './numbers.dart';
import './operation.dart';

class NumButton extends StatefulWidget {
  final int index;
  final NumbersState parent;

  NumButton(this.index, this.parent);

  @override
  State<StatefulWidget> createState() {
    return _NumButtonState();
  }
}

class _NumButtonState extends State<NumButton> {

  void _performOperation(int opIndex) {
    double value;
    for (int i = 0; i < widget.parent.isSelected.length; i++) {
      if (i != widget.index) {
        if (widget.parent.isSelected[i]) {
          switch (opIndex) {
            case 0:
              value = widget.parent.widget.numList[i] +
                  widget.parent.widget.numList[widget.index];
              widget.parent.addOperation(Operation(widget.index, 0, i));
              break;
            case 1:
              value = widget.parent.widget.numList[i] -
                  widget.parent.widget.numList[widget.index];
              widget.parent.addOperation(Operation(widget.index, 1, i));
              break;
            case 2:
              value = widget.parent.widget.numList[i] *
                  widget.parent.widget.numList[widget.index];
              widget.parent.addOperation(Operation(widget.index, 2, i));
              break;
            case 3:
              value = widget.parent.widget.numList[i] /
                  widget.parent.widget.numList[widget.index];
              widget.parent.addOperation(Operation(widget.index, 3, i));
              break;
          }
          widget.parent.changeDisabledButtons(i, true);
          widget.parent.widget.changeNumList(widget.index, value);
          if (value == 24) {
            bool flag = true;
            for (int j = 0; j < widget.parent.disabledButtons.length; j++) {
              if (j != widget.index) {
                if (widget.parent.disabledButtons[j] != true) {
                  flag = false;
                }
              }
            }
            if (flag) {
              widget.parent.createDialog(widget.parent.context);
              StaggeredNumbersState.numCorrect += 1;
              StaggeredNumbersState.current += 10;
            }
          }
        }
      }
    }
  }

  Function _totalFunction() {
    if (widget.parent.disabledButtons[widget.index]) {
      return null;
    } else {
      return () {
        widget.parent.setState(
              () {
            if (widget.parent.opSelected[0]) {
              _performOperation(0);
            } else if (widget.parent.opSelected[1]) {
              _performOperation(1);
            } else if (widget.parent.opSelected[2]) {
              _performOperation(2);
            } else if (widget.parent.opSelected[3]) {
              _performOperation(3);
            }
            for (int i = 0; i < widget.parent.isSelected.length; i++) {
              if (i != widget.index) {
                widget.parent.changeSelected(i, false);
              } else {
                widget.parent.changeSelected(
                    widget.index, !widget.parent.isSelected[i]);
              }
            }
          },
        );
      };
    }
  }

  @override
  Widget build(BuildContext context) {

    return FlatButton(
      color: widget.parent.isSelected[widget.index]
      ? Color.fromRGBO(255, 227, 232, 1.0)
      : Colors.white,
      onPressed: _totalFunction(),
      child: Center(
          child: ConstrainedBox(
            constraints:  const BoxConstraints.expand(),
            child: FittedBox(
              child: Text(
                !widget.parent.disabledButtons[widget.index]
                    ? widget.parent.widget.numList[widget.index].toStringAsFixed(
                    widget.parent.widget.numList[widget.index]
                        .truncateToDouble() ==
                        widget.parent.widget.numList[widget.index]
                        ? 0
                        : 2)
                    : "",
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
          )),
    );
  }
}

