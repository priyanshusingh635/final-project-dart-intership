import 'package:flutter/material.dart';
import 'game.dart'; // Ensure this import points to the correct Game screen file.

class Menu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  void onPlayClicked() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Game()), // Fixed: Ensure `Game` is the correct widget for the game screen.
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Tetris',
            style: TextStyle(
              fontSize: 70.0,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
              shadows: [
                Shadow(
                  color: const Color.fromARGB(255, 245, 244, 244),
                  blurRadius: 8.0,
                  offset: Offset(2.0, 2.0),
                )
              ],
            ),
          ),
          ElevatedButton(
            onPressed: onPlayClicked,
            child: Text('Play'),
          ),
        ],
      ),
    );
  }
}
