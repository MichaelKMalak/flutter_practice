import 'package:bmi_calculator/ResultsPage.dart';
import 'package:flutter/material.dart';
import 'height_card.dart';
import 'package:bmi_calculator/BMItheme.dart';
import 'weight_card.dart';
import 'gender_card.dart';
import 'utils.dart' show screenAwareSize;
import 'gender.dart';

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
        child: //Switch(value: true, onChanged: (val) {}),
        Center(
            child: GestureDetector(
                child: Text('🔥', style: new TextStyle(fontSize: 40.0),),
              onTap: _pushResultPage,
            )
        )
    );
  }


  void _pushResultPage(){
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ResultPage(
            height: height,
            weight: weight,
            gender: gender,
          )
      ),
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
                Expanded(child: GenderCard(
                  gender: gender,
                  onChanged: (val) => setState(() => gender = val),
                )),
                Expanded(child: WeightCard(
                  weight: weight,
                  onChanged: (val) => setState(() => weight = val),
                )),
              ],
            ),
          ),
          Expanded(child: HeightCard(
            height: height,
            onChanged: (val) => setState(() => height = val),
          ))
        ],
      ),
    );
  }
}
