import 'package:flutter/material.dart';
import 'package:bmi_calculator/BMItheme.dart';
import 'package:bmi_calculator/gender.dart';
import 'card_title.dart';
import 'package:bmi_calculator/utils.dart';

class HeightCard extends StatefulWidget {
  final double height;

  const HeightCard({Key key, this.height}) : super(key: key);

  @override
  _HeightCardState createState() => _HeightCardState();
}

class _HeightCardState extends State<HeightCard> {
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
              CardTitle("HEIGHT"),
            ],
          ),
        ),
      ),
    );
  }
}