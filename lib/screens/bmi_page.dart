import 'package:bmi_calculator/screens/result_page.dart';
import 'package:bmi_calculator/widgets/bmi_theme.dart';
import 'package:flutter/material.dart';

import '../model/gender.dart';
import '../widgets/gender_card.dart';
import '../widgets/height_card.dart';
import '../widgets/utils.dart' show screenAwareSize;
import '../widgets/weight_card.dart';

class BmiPage extends StatefulWidget {
  @override
  _BmiPageState createState() => _BmiPageState();
}

class _BmiPageState extends State<BmiPage> {
  Gender gender = Gender.other;
  int height = 180;
  int weight = 70;

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

  Widget _buildBottom(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        height: screenAwareSize(LARGE_PADDING, context),
        width: double.infinity,
        child: //Switch(value: true, onChanged: (val) {}),
            Center(
                child: GestureDetector(
          child: Text(
            '🔥',
            style: new TextStyle(fontSize: 40.0),
          ),
          onTap: _pushResultPage,
        )));
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
                Expanded(
                    child: GenderCard(
                  gender: gender,
                  onChanged: (val) => setState(() => gender = val),
                )),
                Expanded(
                    child: WeightCard(
                  weight: weight,
                  onChanged: (val) => setState(() => weight = val),
                )),
              ],
            ),
          ),
          Expanded(
              child: HeightCard(
            height: height,
            onChanged: (val) => setState(() => height = val),
          ))
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: SMALL_PADDING,
        top: screenAwareSize(MEDIUM_PADDING, context),
      ),
      child: Center(
          child: Text(
        "BMI Calculator",
        style: HEADLINE_STYLE,
      )),
    );
  }

  void _pushResultPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ResultPage(
                height: height,
                weight: weight,
                gender: gender,
              )),
    );
  }
}
