import 'package:bmi_calculator/strings/text.dart';
import 'package:bmi_calculator/widgets/utils.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../model/gender.dart';
import '../widgets/gender_card.dart';
import '../widgets/height_card.dart';
import '../widgets/utils.dart' show screenAwareSize;
import '../widgets/weight_card.dart';


class BmiPage extends StatefulWidget {
  final String name;
  final VoidCallback onChangePage;
  final ValueChanged<Gender> onChangeGender;
  final ValueChanged<int> onChangeHeight;
  final ValueChanged<int> onChangeWeight;

  const BmiPage({Key key,
    this.name,
    this.onChangePage,
    this.onChangeGender,
    this.onChangeHeight,
    this.onChangeWeight,})
      : assert(onChangePage != null),
        super(key: key);

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

  Widget _buildTitle(BuildContext context) {
    final ParentStyle titleStyle = ParentStyle()
      ..margin(
        top: screenAwareSize(MEDIUM_DIM, context),
        left: screenAwareSize(MEDIUM_DIM, context),
      );

    return Parent(
      style: titleStyle,
      child:
      Txt(HI_TXT + widget.name + "👋", style: headlineStyle),
    );
  }

  Widget _buildBottom(BuildContext context) {
    final ParentStyle bottomStyle = ParentStyle()
      ..height(screenAwareSize(LARGE_DIM, context))
      ..width(double.infinity)
      ..alignment.center()
      ..alignmentContent.center();

    return Parent(
      style: bottomStyle,
      gesture: Gestures()
        ..onTap(widget.onChangePage),

      child: Txt('🔥',
          style: TxtStyle()
            ..fontSize(LARGE_FONT)),
    );
  }

  Widget _buildCards(BuildContext context) {
    final ParentStyle mainPageStyle = ParentStyle()
      ..padding(
          left: SMALL_DIM,
          right: SMALL_DIM,
          top: screenAwareSize(SMALL_DIM, context),);

    return Parent(
      style: mainPageStyle,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Expanded(child: GenderCard(
                  gender: gender,
                  onChanged: (val) => setState(() => changeGender(val)),
                )),
                Expanded(child: WeightCard(
                  weight: weight,
                  onChanged: (val) => setState(() => changeWeight(val)),
                )),
              ],
            ),
          ),
          Expanded(child: HeightCard(
            height: height,
            onChanged: (val) => setState(() => changeHeight(val)),
          ))
        ],
      ),
    );
  }

  void changeHeight(int val) {
    widget.onChangeHeight(val);
    height = val;
  }

  void changeWeight(int val) {
    widget.onChangeWeight(val);
    weight = val;
  }

  void changeGender(Gender val) {
    widget.onChangeGender(val);
    gender = val;
  }
}