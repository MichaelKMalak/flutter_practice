import 'package:bmi_calculator/logic/calculator.dart' as calculator;
import 'package:flutter/material.dart';
import '../model/gender.dart';
import 'package:bmi_calculator/widgets/utils.dart';
import '../widgets/utils.dart';
import 'package:division/division.dart';
import 'package:share/share.dart';
import 'package:bmi_calculator/strings/text.dart';


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
    final ParentStyle titleStyle = ParentStyle()
      ..margin(top: MEDIUM_DIM)
      ..alignment.center();

  return Parent(
    style: titleStyle,
    child: Txt(YOU_ARE_TXT + bmiEvaluation,
      style: cardTitleStyle),
  );
  }
  void _popResultPage() =>
      Navigator.pop(context);


  void _popTillNamePage() =>
      Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));


  void _share() =>
      Share.share(MY_BMI_TXT + bmi + I_AM_TXT + bmiEvaluation);


  Widget _buildBottom(BuildContext context) {
    final ParentStyle bottomStyle = ParentStyle()..margin(vertical: 15.0);
    return Parent(
          style: bottomStyle,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  iconSize: 30,
                  color: SECONDARY_BTN_COLOR,
                  onPressed: _popResultPage,
                  tooltip: BACK_TXT,
                ),
                IconButton(
                  icon: Icon(Icons.refresh),
                  iconSize: 50,
                  color: PRIMARY_BTN_COLOR,
                  onPressed: () => _popTillNamePage(),
                  tooltip: RESTART_TXT,
                ),
                IconButton(
                  icon: Icon(Icons.share),
                  iconSize: 30,
                  color: SECONDARY_BTN_COLOR,
                  onPressed: () => _share(),
                  tooltip: SHARE_TXT,
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
    final ParentStyle resultCardStyle = cardStyle ..add(
        ParentStyle()
          ..margin(top: MEDIUM_DIM, horizontal: MEDIUM_DIM)
          ..padding(horizontal: SMALL_DIM, vertical: SMALL_DIM),
      override: true,
    );
    return Parent (
      style: resultCardStyle,
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
