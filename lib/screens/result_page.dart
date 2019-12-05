import 'package:bmi_calculator/strings/text.dart';
import 'package:bmi_calculator/widgets/utils.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

import '../widgets/utils.dart';

class ResultCard extends StatelessWidget {
  final String bmi;

  ResultCard({Key key, this.bmi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ParentStyle resultCardStyle = cardStyle
      ..add(
        ParentStyle()
          ..margin(top: MEDIUM_DIM, horizontal: MEDIUM_DIM)
          ..padding(horizontal: SMALL_DIM, vertical: SMALL_DIM),
        override: true,
      );
    return Parent(
      style: resultCardStyle,
      child: Column(children: [
        Txt(
          '🔥',
          style: headlineStyle,
        ),
        Txt(
          bmi,
          style: resultStyle,
        ),
        Txt(
          '(kg/m²)',
          style: headlineStyle,
        ),
      ]),
    );
  }
}

class ResultPage extends StatefulWidget {
  final String bmi;
  final String bmiEvaluation;
  final VoidCallback onChangeBmi;
  final VoidCallback onChangeName;

  const ResultPage({
    Key key,
    this.bmi,
    this.bmiEvaluation,
    this.onChangeBmi,
    this.onChangeName,
  }) : super(key: key);

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
            Expanded(child: ResultCard(bmi: widget.bmi)),
            _buildBottom(context),
          ],
        ),
      ),
    );
  }

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
              onPressed: widget.onChangeBmi,
              tooltip: BACK_TXT,
            ),
            IconButton(
              icon: Icon(Icons.refresh),
              iconSize: 50,
              color: PRIMARY_BTN_COLOR,
              onPressed: widget.onChangeName,
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

  Widget _buildTitle(BuildContext context) {
    final ParentStyle titleStyle = ParentStyle()
      ..margin(top: MEDIUM_DIM)
      ..alignment.center();

    return Parent(
      style: titleStyle,
      child: Txt(YOU_ARE_TXT + widget.bmiEvaluation, style: cardTitleStyle),
    );
  }

  void _share() =>
      Share.share(MY_BMI_TXT + widget.bmi + I_AM_TXT + widget.bmiEvaluation);
}
