import 'package:flutter/material.dart';
import 'package:bmi_calculator/BMItheme.dart';

class CardTitle extends StatelessWidget {
  final String _title;

  const CardTitle(this._title, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      _title,
      style: TITLE_STYLE,
    );
  }
}