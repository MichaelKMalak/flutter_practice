import 'package:flutter/material.dart';
import 'package:division/division.dart';

const Color PRIMARY_COLOR = Colors.blue;
const Color SECONDARY_COLOR = Colors.blueGrey;
const Color PRIMARY_TXT_COLOR =   Color(4278190080);
const Color SECONDARY_TXT_COLOR =   Colors.grey;
const Color PRIMARY_BTN_COLOR =   Colors.orangeAccent;
const Color SECONDARY_BTN_COLOR = Colors.cyan;

const double SMALL_DIM = 14.0;
const double MEDIUM_DIM = 56.0;
const double LARGE_DIM = 108.0;

const double SMALL_FONT = 14.0;
const double MEDIUM_FONT = 20.0;
const double LARGE_FONT = 40.0;


TxtStyle cardTitleStyle = TxtStyle()
  ..bold()
  ..textColor(PRIMARY_TXT_COLOR)
  ..fontSize(MEDIUM_FONT);

TxtStyle cardSubtitleStyle = TxtStyle()
  ..italic()
  ..textColor(PRIMARY_TXT_COLOR)
  ..fontSize(SMALL_FONT);

TxtStyle headlineStyle = TxtStyle()
  ..letterSpacing(2.0)
  ..bold()
  ..textColor(PRIMARY_TXT_COLOR)
  ..fontSize(LARGE_FONT);

const TextStyle HEADLINE_STYLE = const TextStyle(letterSpacing: 2.0,
    fontWeight: FontWeight.bold,
    fontSize: 50.0,
    color: PRIMARY_TXT_COLOR);

const TextStyle SECONDARY_BTN_STYLE = const TextStyle(color: SECONDARY_BTN_COLOR,
    fontWeight: FontWeight.bold,
    fontSize: 26.0);

const TextStyle PRIMARY_BTN_STYLE = const TextStyle( fontSize: 18,
    fontWeight: FontWeight.normal,
    letterSpacing: 1,wordSpacing: 2,
    color: PRIMARY_BTN_COLOR);

const TextStyle WEIGHT_TEXT_STYLE = const TextStyle(
  color: Color.fromRGBO(196, 197, 203, 1.0),
  fontSize: 16.0,
);
const TextStyle HIGHLIGHTED_WEIGHT_TEXT_STYLE = const TextStyle(
  color: Color.fromRGBO(77, 123, 243, 1.0),
  fontSize: 32.0,

);
const TextStyle LABELS_TEXT_STYLE = const TextStyle(
  color: Color.fromRGBO(216, 217, 223, 1.0),
  fontSize: 16.0,

);
const TextStyle HIGHLIGHTED_HEIGHT_TEXT_STYLE = const TextStyle(
  fontSize: 20.0,
  color: Colors.black54,
  fontWeight: FontWeight.w600,
);
