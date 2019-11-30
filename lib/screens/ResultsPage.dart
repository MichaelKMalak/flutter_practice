import 'package:bmi_calculator/logic/calculator.dart' as calculator;
import 'package:flutter/material.dart';
import '../model/gender.dart';
import 'package:bmi_calculator/widgets/utils.dart';
import '../widgets/utils.dart';
import 'package:division/division.dart';

class ResultPage extends StatefulWidget {
  final int height;
  final int weight;
  final Gender gender;

  const ResultPage({Key key, this.height, this.weight, this.gender}) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildTitle(context),
            Expanded(child: ResultCard(
                bmi:calculator.calculateBMI(
                  height: widget.height,
                  weight: widget.weight,
                ))
            ),
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
      child: Center(child: Text(
        calculator.evaluateBMI(bmi: calculator.calculateBMI(
          height: widget.height,
          weight: widget.weight,
        )),
        style: HEADLINE_STYLE,
      )),
    );
  }

  Widget _buildBottom(BuildContext context) {
    return Parent(
      style: ParentStyle()
        ..alignment.center()
        ..margin(bottom: MEDIUM_DIM),

      gesture: Gestures()
        ..isTap((isTapped) =>
            setState(() => _popResultPage())),
      child: Icon(Icons.refresh, size: 40, color: Color(0xFF42526F)),
    );
  }

  void _popResultPage(){
    Navigator.pop(context);
  }

}

class ResultCard extends StatelessWidget {
  final double bmi;

  ResultCard({Key key, this.bmi})
      : super(key: key);

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
              bmi.toStringAsFixed(1),
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
