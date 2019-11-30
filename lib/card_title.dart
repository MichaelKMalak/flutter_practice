import 'package:flutter/material.dart';
import 'package:bmi_calculator/BMItheme.dart';
import 'package:division/division.dart';

class CardTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  CardTitle(this.title, {Key key, this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Txt(title, style: cardTitleStyle),
        Txt(subtitle ?? "", style: cardSubtitleStyle),
      ],
    );
  }
}