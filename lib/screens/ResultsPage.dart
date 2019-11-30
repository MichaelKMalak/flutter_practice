import 'package:bmi_calculator/logic/calculator.dart' as calculator;
import 'package:flutter/material.dart';
import '../model/gender.dart';
import 'package:bmi_calculator/widgets/utils.dart';
import '../widgets/utils.dart';
import 'package:division/division.dart';
import 'package:share/share.dart';

class ResultPage extends StatefulWidget {
  final int height;
  final int weight;
  final Gender gender;

  const ResultPage({Key key, this.height, this.weight, this.gender})
      : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  String get bmi => calculator
      .calculateBMI(
        height: widget.height,
        weight: widget.weight,
      )
      .toStringAsFixed(1);

  String get bmiEvaluation => calculator.evaluateBMI(
        bmiStr: bmi,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildTitle(context),
            Expanded(child: ResultCard(bmi: bmi)),
            _buildBottom(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: SMALL_DIM,
        top: screenAwareSize(MEDIUM_DIM, context),
      ),
      child: Center(
          child: Text(
        bmiEvaluation,
        style: HEADLINE_STYLE,
      )),
    );
  }

  Widget _buildBottom(BuildContext context) {
    return Parent(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  iconSize: 30,
                  color: SECONDARY_BTN_COLOR,
                  onPressed: _popResultPage,
                  tooltip: "Back",
                ),
                IconButton(
                  icon: Icon(Icons.refresh),
                  iconSize: 50,
                  color: PRIMARY_BTN_COLOR,
                  onPressed: () => _popTillNamePage(),
                  tooltip: "Restart",
                ),
                IconButton(
                  icon: Icon(Icons.share),
                  iconSize: 30,
                  color: SECONDARY_BTN_COLOR,
                  onPressed: () =>
                      Share.share("My BMI = $bmi. I am ${bmiEvaluation.toLowerCase()}."),
                  tooltip: "Share",
                )
              ]),
        );
  }

  void _popResultPage() {
    Navigator.pop(context);
  }

  void _popTillNamePage() {
    Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
  }
}

class ResultCard extends StatelessWidget {
  final String bmi;

  ResultCard({Key key, this.bmi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(SMALL_DIM),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: MEDIUM_DIM),
        child: Container(
          width: double.infinity,
          child: Column(children: [
            Text(
              '🔥',
              style: TextStyle(fontSize: 60.0, color: Colors.redAccent),
            ),
            Text(
              bmi,
              style: TextStyle(fontSize: 130.0, fontWeight: FontWeight.w900),
            ),
            Text(
              '(kg/m²)',
              style: TextStyle(fontSize: 30.0),
            ),
          ]),
        ),
      ),
    );
  }
}
