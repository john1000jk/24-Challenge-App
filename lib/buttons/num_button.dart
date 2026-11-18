import 'package:flutter/material.dart';
import 'package:twenty_four_game/screens/time_trial/staggered_numbers.dart';
import 'package:twenty_four_game/themes/styles.dart';
import '../screens/practice/numbers.dart';
import 'operation.dart';

class NumButton extends StatefulWidget {
  final int index;
  final NumbersState parent;

  const NumButton(this.index, this.parent, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _NumButtonState();
  }
}

class _NumButtonState extends State<NumButton> {

  /// Combines the selected number with this one using operator [opIndex].
  /// Returns false if the move isn't allowed (dividing by zero), in which
  /// case the board is left unchanged.
  bool _performOperation(int opIndex) {
    for (int i = 0; i < widget.parent.isSelected.length; i++) {
      if (i != widget.index) {
        if (widget.parent.isSelected[i]) {
          final numList = widget.parent.widget.numList;
          final value = applyOperation(opIndex, numList[i], numList[widget.index]);
          if (value == null) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(const SnackBar(
                content: Text("Can't divide by 0"),
                duration: Duration(seconds: 2),
              ));
            return false;
          }
          widget.parent.addOperation(Operation(widget.index, opIndex, i,
              previousValue: numList[widget.index]));
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
              widget.parent.skipped = false;
              if (widget.parent is StaggeredNumbersState) {
                StaggeredNumbersState.numCorrect += 1;
                StaggeredNumbersState.current += 10;
              }
            }
          }
        }
      }
    }
    return true;
  }

  VoidCallback? _totalFunction() {
    if (widget.parent.disabledButtons[widget.index]) {
      return null;
    } else {
      return () {
        widget.parent.setState(
              () {
            final opIndex = widget.parent.opSelected.indexOf(true);
            if (opIndex != -1 && !_performOperation(opIndex)) {
              // Move refused: keep the current selection so the player
              // can pick a different number.
              return;
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

    return MaterialButton(
      enableFeedback: false,
      elevation: 0,
      color: widget.parent.isSelected[widget.index]
      ? Color.fromRGBO(255, 222, 222, 1.0)
      : accentColor,
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
                style: TextStyle(
                  fontSize: 96,
                  fontWeight: FontWeight.w200,
                  color: Color.fromRGBO(71, 71, 71, 1.0),
                ),
              ),
            ),
          )),
    );
  }
}

