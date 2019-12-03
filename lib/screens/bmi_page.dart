import 'package:bmi_calculator/screens/result_page.dart';
import 'package:flutter/material.dart';
import '../widgets/height_card.dart';
import 'package:bmi_calculator/widgets/utils.dart';
import '../widgets/weight_card.dart';
import '../widgets/gender_card.dart';
import '../widgets/utils.dart' show screenAwareSize;
import '../model/gender.dart';
import 'package:division/division.dart';
import 'package:bmi_calculator/strings/text.dart';


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

  Widget _buildTitle(BuildContext context) {
    final ParentStyle titleStyle = ParentStyle()
      ..margin(
        top: screenAwareSize(MEDIUM_DIM, context),
        left: screenAwareSize(MEDIUM_DIM, context),
      );

    return Parent(
      style: titleStyle,
      gesture: Gestures()
        ..onTap(_popTillNamePage),
      child:
      Txt(HI_TXT + widget.name + "👋", style: headlineStyle),
    );
  }

  void _popTillNamePage() =>
      Navigator.popUntil(
          context, ModalRoute.withName(Navigator.defaultRouteName));

  Widget _buildBottom(BuildContext context) {
    final ParentStyle bottomStyle = ParentStyle()
      ..height(screenAwareSize(LARGE_DIM, context))
      ..width(double.infinity)
      ..alignment.center()
      ..alignmentContent.center();

    return Parent(
      style: bottomStyle,
      gesture: Gestures()
        ..onTap(_pushResultPage),

      child: Txt('🔥',
          style: TxtStyle()
            ..fontSize(LARGE_FONT)),
    );
  }


  void _pushResultPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              ResultPage(
                height: height,
                weight: weight,
                gender: gender,
              )
      ),
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