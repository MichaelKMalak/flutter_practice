import 'package:bmi_calculator/screens/ResultsPage.dart';
import 'package:flutter/material.dart';
import '../widgets/height_card.dart';
import 'package:bmi_calculator/widgets/utils.dart';
import '../widgets/weight_card.dart';
import '../widgets/gender_card.dart';
import '../widgets/utils.dart' show screenAwareSize;
import '../model/gender.dart';
import 'package:division/division.dart';

class BmiPage extends StatefulWidget {
  final String name;

  const BmiPage({Key key, this.name}) : super(key: key);

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
    return Parent(
        style: ParentStyle()
          ..margin(
              top: screenAwareSize(MEDIUM_DIM, context),
              left: screenAwareSize(MEDIUM_DIM, context),
          ),
        gesture: Gestures()
          ..isTap((isTapped) =>
            setState(() => Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName)))),
        child:
            Txt("Hi ${widget.name} 👋", style: headlineStyle),
        );
  }

  Widget _buildBottom (BuildContext context) {
    return Container(
        alignment: Alignment.center,
        height: screenAwareSize(LARGE_DIM, context),
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
        left: SMALL_DIM,
        right: SMALL_DIM,
        top: screenAwareSize(SMALL_DIM, context),
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
