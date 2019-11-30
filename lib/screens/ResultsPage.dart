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
  return Parent(
    style: ParentStyle()
      ..margin(
          top: MEDIUM_DIM
      )
      ..alignment.center(),
    child: Txt("You are $bmiEvaluation",
      style: cardTitleStyle
    ),
  );
  }
  void _popResultPage() =>
      Navigator.pop(context);


  void _popTillNamePage() =>
      Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));


  void _share() =>
      Share.share("My BMI = $bmi. I am ${bmiEvaluation.toLowerCase()}.");


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
                  onPressed: () => _share(),
                  tooltip: "Share",
                )
              ]),
        );
  }
}


class ResultCard extends StatelessWidget {
  final String bmi;

  ResultCard({Key key, this.bmi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  final ParentStyle cardStyle = ParentStyle()
    ..alignment.center()
    ..alignmentContent.center()
    ..background.color(Colors.white)
    ..margin(all: MEDIUM_DIM)
    ..padding(horizontal: 30.0, vertical: 30.0)
    ..elevation(10, color: hex('#3977FF'))
    ..scale(1.0)
    ..borderRadius(all: 20.0)
    ..ripple(true);

    return Parent (
      style: cardStyle,
      child: Column(children: [
            Txt('🔥',
              style: headlineStyle,),
            Txt(bmi,
              style: resultStyle,),
            Txt('(kg/m²)',
              style: headlineStyle,),
          ]),
    );
  }
}
