import 'package:flutter/material.dart';

const double BASE_HEIGHT = 650.0;

//To convert the design value to device value so that proportions will remain the same
double screenAwareSize(double size, BuildContext context) {
  return size * MediaQuery.of(context).size.shortestSide  / BASE_HEIGHT;
}