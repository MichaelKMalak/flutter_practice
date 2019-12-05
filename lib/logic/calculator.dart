import 'dart:math' as math;

import 'package:bmi_calculator/strings/text.dart';

//Note: I didn't take gender into consideration
double calculateBMI({int height, int weight}) =>
    weight / _heightSquared(height);

String evaluateBMI({String bmiStr}) {
  double bmi = double.parse(bmiStr);
  if (bmi < 18.5)
    return UNDERWEIGHT_TXT;
  else if (bmi >= 18.5 && bmi < 25)
    return NORMAL_TXT;
  else if (bmi > 25 && bmi <= 29.99)
    return OVERWEIGHT_TXT;
  else
    return OBESE_TXT;
}

double _heightSquared(int height) => math.pow(height / 100, 2);
