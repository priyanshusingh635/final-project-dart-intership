import 'block.dart';
import 'point.dart';
import 'package:flutter/material.dart';

class Tblock extends Block{
  Tblock(int width){
    points[0] = Point((width/2 - 1).floor(), 0);
    points[1] = Point((width/2 + 0).floor(), 0);
    points[2] = Point((width/2 + 1).floor(), 0);
    points[3] = Point((width/2 + 0).floor(), -1);
    rotationCenter = points[1];
    color = Colors.green;
}
}