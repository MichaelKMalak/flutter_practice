import 'package:flutter/material.dart';
import 'package:flutter_practice/BMItheme.dart';
import 'package:flutter_practice/gender.dart';
import 'package:flutter_practice/bmi_page/card_title.dart';
import 'package:flutter_practice/utils.dart';

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