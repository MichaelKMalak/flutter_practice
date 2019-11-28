import 'package:flutter/material.dart';
import 'height_card.dart';
import 'package:bmi_calculator/BMItheme.dart';
import 'weight_card.dart';
import 'gender_card.dart';
import 'utils.dart' show screenAwareSize;

class BmiPage extends StatefulWidget {
  @override
  _BmiPageState createState() => _BmiPageState();
}

class _BmiPageState extends State<BmiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildTitle(context),
            Expanded(child: _buildCards(context)),
            _buildBottom(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle (BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: SMALL_PADDING,
        top: screenAwareSize(MEDIUM_PADDING, context),
      ),
      child: Center(child:Text(
        "BMI Calculator",
        style: HEADLINE_STYLE,
      )),
    );
  }
  Widget _buildBottom (BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: screenAwareSize(LARGE_PADDING, context),
      width: double.infinity,
      child: Switch(value: true, onChanged: (val) {}),
    );
  }
  Widget _buildCards(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: SMALL_PADDING,
        right: SMALL_PADDING,
        top: screenAwareSize(SMALL_PADDING, context),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Expanded(child: GenderCard()),
                Expanded(child: WeightCard()),
              ],
            ),
          ),
          Expanded(child: HeightCard())
        ],
      ),
    );
  }
}
