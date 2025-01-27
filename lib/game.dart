import 'package:flutter/material.dart';
import 'blocks/alivePoint.dart';
import 'helper.dart';
import 'dart:async';
import 'blocks/block.dart';
import 'scoreDisplay.dart';
import 'userInput.dart';

enum LastButtonPressed { LEFT, RIGHT, ROTATE_LEFT,  ROTATE_RIGHT,NONE}
//enum MoveDir { LEFT, RIGHT, DOWN }

const int BOARD_WIDTH = 10;
const int BOARD_HEIGHT = 20;

const double WIDTH = 200;
const double HEIGHT = 400;

const double POINT_SIZE = 20;

const int GAME_SPEED = 400;
Timer? timer;

class Game extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Game();
}

class _Game extends State<Game> {
  LastButtonPressed performAction = LastButtonPressed.NONE;
  Block? currentBlock;
  List<AlivePoint> alivePoints = [];
  int score = 0;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void onActionButtonPressed(LastButtonPressed newAction) {
    setState(() {
      performAction = newAction;
    });
  }

  void startGame() {
    setState(() {
      currentBlock = getRandomBlock();
    });
    timer = Timer.periodic(
      Duration(milliseconds: GAME_SPEED),
      onTimeTick,
    );
  }

  void saveOldBlock() {
    currentBlock?.points.forEach((point) {
      AlivePoint newPoint = AlivePoint(point.x, point.y, currentBlock!.color);
      setState(() {
        alivePoints.add(newPoint);
      });
    });
  }

  void onTimeTick(Timer time) {
    if (currentBlock == null || playerLost()) return;

    removeFullRows();

    if (currentBlock!.isAtBottom() || isAboveOldBlock()) {
      saveOldBlock();
      print('Spawning new random block...');
      setState(() {
        currentBlock = getRandomBlock();
      });
    } else {
      setState(() {
        currentBlock!.move(MoveDir.DOWN);
      });
    }

    checkForUserInput();
  }

  bool isAboveOldBlock() {
    bool retVal = false;
    alivePoints.forEach((oldPoint) {
      if (oldPoint.checkIfPointCollide(currentBlock!.points)) {
        retVal = true;
      }
    });

    return retVal;
  }

  void removeRow(int row) {
    setState(() {
      alivePoints.removeWhere((point) => point.y == row);

      alivePoints.forEach((point) {
        if (point.y < row) {
          point.y += 1;
        }
      });

      score += 1;
    });
  }

  void removeFullRows() {
    for (int currentRow = 0; currentRow < BOARD_HEIGHT; currentRow++) {
      int counter = 0;
      alivePoints.forEach((point) {
        if (point.y == currentRow) {
          counter++;
        }
      });

      if (counter == BOARD_WIDTH) {
        removeRow(currentRow);
      }
    }
  }

  bool playerLost() {
    bool retVal = false;

    alivePoints.forEach((point) {
      if (point.y <= 0) {
        retVal = true;
      }
    });

    return retVal;
  }

  void checkForUserInput() {
    if (performAction != LastButtonPressed.NONE) {
      setState(() {
        switch (performAction) {
          case LastButtonPressed.LEFT:
            currentBlock?.move(MoveDir.LEFT);
            break;
          case LastButtonPressed.RIGHT:
            currentBlock?.move(MoveDir.RIGHT);
            break;
          case LastButtonPressed.ROTATE_LEFT:
            currentBlock?.rotateLeft();
            break;
            case LastButtonPressed.ROTATE_RIGHT:
            currentBlock?.rotateLeft();
            break;
          case LastButtonPressed.NONE:
            break;
        }
      });
    }
  }

  Widget drawTetrisBlocks() {
    if (currentBlock == null) return SizedBox.shrink();

    List<Positioned> visiblePoints = [];

    currentBlock!.points.forEach((point) {
      visiblePoints.add(
        Positioned(
          child: getTetisPoint(currentBlock!.color),
          left: point.x * POINT_SIZE,
          top: point.y * POINT_SIZE,
        ),
      );
    });

    alivePoints.forEach((point) {
      visiblePoints.add(
        Positioned(
          child: getTetisPoint(point.color),
          left: point.x * POINT_SIZE,
          top: point.y * POINT_SIZE,
        ),
      );
    });

    return Stack(children: visiblePoints);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Center(
          child: Container(
            width: WIDTH,
            height: HEIGHT,
            decoration: BoxDecoration(
              border: Border.all(color: const Color.fromARGB(255, 248, 246, 246)),
            ),
            child: (!playerLost())
                ? drawTetrisBlocks()
                : getGameOverText(score),
          ),
        ),
        Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Use spaceBetween for alignment
  children: <Widget>[
    Expanded(
      flex: 1, // Give the score area some space
      child: ScoreDisplay(score),
    ),
    Expanded(
      flex: 1, // Allow more space for buttons
      child: UserInput(onActionButtonPressed),
    ),
          ],
        )
      ],
    );
  }
}
