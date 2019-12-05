import 'package:division/division.dart';
import 'package:flutter/material.dart';

const double BASE_HEIGHT = 650.0;

const TextStyle LABELS_TEXT_STYLE = const TextStyle(
  color: SECONDARY_COLOR,
  fontSize: 16.0,
);
const double LARGE_DIM = 108.0;
const double LARGE_FONT = 40.0;
const double MEDIUM_DIM = 56.0;
const double MEDIUM_FONT = 24.0;
const Color PRIMARY_BTN_COLOR = Color(0xFF42526F);

const Color PRIMARY_COLOR = Colors.blue;
const Color PRIMARY_TXT_COLOR = Color(4278190080);
const Color SECONDARY_BTN_COLOR = Colors.grey;

const Color SECONDARY_COLOR = Color.fromRGBO(216, 217, 223, 1.0);
const Color SECONDARY_TXT_COLOR = Colors.blue;
const double SMALL_DIM = 14.0;
const double SMALL_FONT = 14.0;

//To convert the design value to device value so that proportions will remain the same
const double XLARGE_FONT = 100.0;

ParentStyle cardStyle = ParentStyle()
  ..alignment.center()
  ..alignmentContent.center()
  ..background.color(Colors.white)
  ..elevation(3, color: hex('#3977FF'))
  ..scale(1.0)
  ..borderRadius(all: 20.0);

TxtStyle cardSubtitleStyle = TxtStyle()
  ..italic()
  ..textColor(PRIMARY_TXT_COLOR)
  ..fontSize(SMALL_FONT);

TxtStyle cardTitleStyle = TxtStyle()
  ..bold()
  ..textColor(PRIMARY_TXT_COLOR)
  ..fontSize(MEDIUM_FONT);

TxtStyle headlineStyle = TxtStyle()
  ..letterSpacing(2.0)
  ..bold()
  ..textColor(PRIMARY_TXT_COLOR)
  ..fontSize(LARGE_FONT);

TxtStyle resultStyle = TxtStyle()
  ..letterSpacing(2.0)
  ..bold()
  ..textColor(PRIMARY_TXT_COLOR)
  ..fontSize(XLARGE_FONT);

double screenAwareSize(double size, BuildContext context) {
  return size * MediaQuery
      .of(context)
      .size
      .shortestSide / BASE_HEIGHT;
}
