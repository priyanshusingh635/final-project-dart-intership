import 'point.dart';
import 'package:flutter/material.dart';
import '../game.dart';

enum MoveDir { LEFT, RIGHT, DOWN }

class Block {
  List<Point> points = List<Point>.filled(4, Point(0, 0));
  Point rotationCenter = Point(0, 0);
  late Color color;

  void move(MoveDir dir) {
    switch (dir) {
      case MoveDir.LEFT:
        if (canMoveToSide(-1)) {
          points.forEach((p) => p.x -= 1);
        }
        break;
      case MoveDir.RIGHT:
        if (canMoveToSide(1)) {
          points.forEach((p) => p.x += 1);
        }
        break;
      case MoveDir.DOWN:
        points.forEach((p) => p.y += 1);
        break;
    }
  }

  bool canMoveToSide(int movement) {
    for (var point in points) {
      if (point.x + movement < 0 || point.x + movement >= BOARD_WIDTH) {
        return false;
      }
    }
    return true;
  }

  bool allPointsInside() {
    for (var point in points) {
      if (point.x < 0 || point.x >= BOARD_WIDTH) {
        return false;
      }
    }
    return true;
  }

  void rotateRight() {
    for (var point in points) {
      int x = point.x;
      point.x = rotationCenter.x - point.y + rotationCenter.y;
      point.y = rotationCenter.y + x - rotationCenter.x;
    }

    if (!allPointsInside()) {
      rotateLeft();
    }
  }

  void rotateLeft() {
    for (var point in points) {
      int x = point.x;
      point.x = rotationCenter.x + point.y - rotationCenter.y;
      point.y = rotationCenter.y - x + rotationCenter.x;
    }

    if (!allPointsInside()) {
      rotateRight();
    }
  }

  bool isAtBottom() {
    int lowestPoint = 0;

    for (var point in points) {
      if (point.y > lowestPoint) {
        lowestPoint = point.y;
      }
    }

    return lowestPoint >= BOARD_HEIGHT - 1;
  }
}
