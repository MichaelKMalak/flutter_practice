import 'dart:math' as math;

//Note: I didn't take gender into consideration

double _heightSquared(int height) => math.pow(height / 100, 2);

double calculateBMI({int height, int weight}) => weight / _heightSquared(height);

String evaluateBMI({double bmi}) {
  if (bmi < 18.5)
    return "UNDERWEIGHT";
  else if (bmi >= 18.5 && bmi < 25)
    return "NORMAL";
  else if (bmi > 25 && bmi <= 29.99)
    return "OVERWEIGHT";
  else
    return "OBESE";
}