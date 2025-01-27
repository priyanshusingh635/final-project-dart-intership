import 'package:flutter/material.dart';
import 'blocks/block.dart';
import 'blocks/Iblock.dart';
import 'blocks/Jblock.dart';
import 'blocks/Lblock.dart';
import 'blocks/Sblock.dart';
import 'blocks/sqBlock.dart';
import 'blocks/Tblock.dart';
import 'dart:math';
import 'game.dart';

Block getRandomBlock() {
  int randomNr = Random().nextInt(6); // Changed to 6 to match the number of cases
  switch (randomNr) {
    case 0:
      return Iblock(BOARD_WIDTH);
    case 1:
      return JBlock(BOARD_WIDTH);
    case 2:
      return LBlock(BOARD_WIDTH);
    case 3:
      return SBlock(BOARD_WIDTH); // Fixed typo: 'Sbblock' to 'Sblock'
    case 4:
      return SquareBlock(BOARD_WIDTH); // Fixed typo: 'Squarelock' to 'SquareBlock'
    case 5:
      return Tblock(BOARD_WIDTH); // Fixed typo: 'TBlock' to 'Tblock'
    default:
      throw Exception('Invalid block type');
  }
}

Widget getTetisPoint(Color color) {
  return Container(
    width: POINT_SIZE,
    height: POINT_SIZE,
    decoration: BoxDecoration(
      color: color,
      shape: BoxShape.rectangle,
    ),
  );
}

Widget getGameOverText(int score) {
  return Center(
    child: Text(
      'Game Over\nEnd Score: $score',
      style: TextStyle(
        fontSize: 35,
        fontWeight: FontWeight.bold,
        color: const Color.fromARGB(255, 244, 244, 245),
        shadows: [
          Shadow(
            color: const Color.fromARGB(255, 226, 234, 10),
            blurRadius: 3.0,
            offset: Offset(2.0, 2.0),
          )
        ],
      ),
    ),
  );
}
