import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twenty_four_game/themes/styles.dart';
import '../screens/practice/numbers.dart';

class OpButton extends StatefulWidget {
  final int index;
  final NumbersState parent;

  OpButton(this.index, this.parent);

  @override
  State<StatefulWidget> createState() {
    return _OpButtonState();
  }
}

class _OpButtonState extends State<OpButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Ink(
        decoration: BoxDecoration(
          border: widget.parent.opSelected[widget.index]
              ? Border.all(color: AppTheme().accentColor, width: 0.0)
              : Border.all(color: AppTheme().accentColor, width: 0.0),
          color: widget.parent.opSelected[widget.index]
          ? widget.parent.opColors[widget.index]
          : AppTheme().accentColor,
          shape: BoxShape.rectangle,
        ),
        child: FittedBox(
          fit: BoxFit.contain,
          child: IconButton(
            onPressed: () => widget.parent.setState(
              () {
                for (int i = 0; i < widget.parent.opSelected.length; i++) {
                  if (i != widget.index) {
                    widget.parent.changeOPSelected(i, false);
                  } else {
                    widget.parent
                        .changeOPSelected(widget.index, !widget.parent.opSelected[widget.index]);
                  }
                }
              },
            ),
            icon: widget.parent.operators[widget.index],
            iconSize: widget.index != 3 ? 500 : 500,
          ),
        ),
      ),
    );
  }
}
