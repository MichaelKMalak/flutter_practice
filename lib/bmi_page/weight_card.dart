import 'package:flutter/material.dart';
import 'package:flutter_practice/BMItheme.dart';
import 'package:flutter_practice/gender.dart';
import 'package:flutter_practice/bmi_page/card_title.dart';
import 'package:flutter_practice/utils.dart';

class WeightCard extends StatefulWidget {
  final double weight;

  const WeightCard({Key key, this.weight}) : super(key: key);

  @override
  _WeightCardState createState() => _WeightCardState();
}

class _WeightCardState extends State<WeightCard> {
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
              CardTitle("WEIGHT"),
            ],
          ),
        ),
      ),
    );
  }
}