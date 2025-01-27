import 'package:flutter/material.dart';
import 'game.dart';

class ActionButton extends StatelessWidget {
  final Function onClickedFunction; // Changed to `final` for immutability
  final Icon buttonIcon; // Changed to `final` for immutability

  ActionButton(this.onClickedFunction, this.buttonIcon);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      child: Padding(
        padding: EdgeInsets.all(5),
        child: ElevatedButton( // Changed from `RaisedButton` to `ElevatedButton`
          onPressed: () {
            onClickedFunction();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue, // `color` replaced with `backgroundColor`
          ),
          child: buttonIcon,
        ),
      ),
    );
  }
}
