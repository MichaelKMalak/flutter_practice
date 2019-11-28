import 'package:bmi_calculator/calculator.dart' as calculator;
import 'package:flutter/material.dart';
import 'gender.dart';
import 'package:bmi_calculator/BMItheme.dart';
import 'utils.dart';

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
        left: SMALL_PADDING,
        top: screenAwareSize(MEDIUM_PADDING, context),
      ),
      child: Center(child: Text(
        "Your BMI is",
        style: HEADLINE_STYLE,
      )),
    );
  }

  Widget _buildBottom(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: screenAwareSize(LARGE_PADDING, context),
      width: double.infinity,
      child: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 30.0,),
          onPressed: _popResultPage,
        ),
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
      margin: EdgeInsets.all(MEDIUM_PADDING),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: MEDIUM_PADDING),
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
