import 'package:flutter/material.dart';
import 'package:twenty_four_game/themes/styles.dart';
import '../screens/practice/numbers.dart';

class OpButton extends StatefulWidget {
  final int index;
  final NumbersState parent;

  const OpButton(this.index, this.parent, {super.key});

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
              ? Border.all(color: accentColor, width: 0.0)
              : Border.all(color: accentColor, width: 0.0),
          color: widget.parent.opSelected[widget.index]
          ? widget.parent.opColors[widget.index]
          : accentColor,
          shape: BoxShape.rectangle,
        ),
        child: FittedBox(
          fit: BoxFit.contain,
          child: MaterialButton(
            enableFeedback: false,
            elevation: 0,
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
            child: widget.parent.operators[widget.index],
          ),
        ),
      ),
    );
  }
}
