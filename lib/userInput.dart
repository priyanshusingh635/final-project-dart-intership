import 'package:flutter/material.dart';
import 'actionButton.dart';
import 'game.dart';

class UserInput extends StatelessWidget {
  final Function(LastButtonPressed) onActionButtonPressed; // Explicit type for clarity
  UserInput(this.onActionButtonPressed);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Align buttons properly
          children: <Widget>[
            ActionButton(
              () => onActionButtonPressed(LastButtonPressed.ROTATE_LEFT), // Pass enum value explicitly
              Icon(Icons.rotate_left),
            ),
            ActionButton(
              () => onActionButtonPressed(LastButtonPressed.ROTATE_RIGHT),
              Icon(Icons.rotate_right),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ActionButton(
              () => onActionButtonPressed(LastButtonPressed.LEFT),
              Icon(Icons.arrow_left),
            ),
            ActionButton(
              () => onActionButtonPressed(LastButtonPressed.RIGHT),
              Icon(Icons.arrow_right),
            ),
          ],
        ),
      ],
    );
  }
}
