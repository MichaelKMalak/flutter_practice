import 'package:flutter/material.dart';
import 'package:flutter_practice/BMItheme.dart';
import 'package:flutter_practice/gender.dart';
import 'package:flutter_practice/bmi_page/card_title.dart';
import 'package:flutter_practice/utils.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

double circleRadius(BuildContext context) => screenAwareSize(150, context);
const double _DEFAULT_ANGLE = math.pi / 4;
const Map<Gender, double> _GENDER_ANGLES = {
  Gender.female: -_DEFAULT_ANGLE,
  Gender.other: 0.0,
  Gender.male: _DEFAULT_ANGLE,
};
const Map<Gender, String> _GENDER_SVG = {
  Gender.female: "images/gender_female.svg",
  Gender.other: "images/gender_other.svg",
  Gender.male: "images/gender_male.svg",
};

class GenderCard extends StatefulWidget {
  final Gender gender;

  const GenderCard({Key key, this.gender}) : super(key: key);

  @override
  _GenderCardState createState() => _GenderCardState();
}

class _GenderCardState extends State<GenderCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.only(top: screenAwareSize(SMALL_PADDING, context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CardTitle("GENDER"),
              Padding(
                padding: EdgeInsets.only(top: screenAwareSize(SMALL_PADDING, context)),
                child: _drawMainStack(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _drawMainStack() {
  return Stack(
    alignment: Alignment.bottomCenter,
    children: <Widget>[
      DrawCircle(),
      DrawGenderIcon(gender: Gender.other),
    ],
  );
}

class DrawCircle extends StatelessWidget{

@override
Widget build(BuildContext context) {
  return Stack(
    alignment: Alignment.center,
    children: <Widget>[
      Container(
        width: circleRadius(context),
        height: circleRadius(context),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blueGrey,
        ),
      ),
    ],
  );
}}

class DrawGenderIcon extends StatelessWidget {
  final Gender gender;
  const DrawGenderIcon({Key key, this.gender}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget icon = Padding(
      padding: EdgeInsets.only(left: screenAwareSize(SMALL_PADDING, context)),
      child: SvgPicture.asset(
        _GENDER_SVG[gender],
        height: screenAwareSize(50.0, context),
        width: screenAwareSize(50.0, context),
      ),
    );

  return icon;
  }
}