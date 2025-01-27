import 'point.dart';
import 'package:flutter/material.dart';

class AlivePoint extends Point{
  //int x; -> defint point class 
  //int y; -> defint point class

  Color color;

  AlivePoint(int x, int y, Color col)  : color = col, super(x, y);

  //Alivepoint(int x, int y, this.color) : super(x,y);

  bool checkIfPointCollide(List<Point>pointList){
    bool retVal = false;

    pointList.forEach((pointToCheck){
      if(pointToCheck.x == x && pointToCheck.y == y-1){
        retVal = true;
      }
    });

    return retVal;
}

}