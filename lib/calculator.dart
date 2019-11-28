import 'dart:math' as math;

//Note: I didn't take gender into consideration

double _heightSquared(int height) => math.pow(height / 100, 2);

double calculateBMI({int height, int weight}) => weight / _heightSquared(height);
