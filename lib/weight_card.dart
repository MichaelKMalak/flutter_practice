import 'package:bmi_calculator/BMItheme.dart';
import 'package:bmi_calculator/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'card_title.dart';

class WeightCard extends StatefulWidget {
  @override
  _WeightCardState createState() => _WeightCardState();
}

class _WeightCardState extends State<WeightCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.only(top: screenAwareSize(SMALL_PADDING, context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CardTitle("WEIGHT", subtitle: "(KG)"),
              _drawSlider(),
            ],
          ),
        ),
      ),
    );
  }
  Widget _drawSlider() {
    return Expanded(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: WeightBackground(
              child: LayoutBuilder(
                builder: (context, constraints) => WeightSlider(
                  minValue: 30,
                  maxValue: 200,
                  width: constraints.maxWidth,
                  ),
              ),
      ),
    )
    )
    );
  }
}

class WeightBackground extends StatelessWidget {
  final Widget child;

  const WeightBackground({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          height: screenAwareSize(200.0, context),
          decoration: BoxDecoration(
            color: Color.fromRGBO(244, 244, 244, 1.0),
            borderRadius:
            new BorderRadius.circular(screenAwareSize(250.0, context)),
          ),
          child: child,
        ),
        SvgPicture.asset(
          "images/weight_arrow.svg",
          height: screenAwareSize(20.0, context),
          width: screenAwareSize(35.0, context),
        ),
      ],
    );
  }
}

class WeightSlider extends StatelessWidget {
  WeightSlider({
    Key key,
    @required this.minValue,
    @required this.maxValue,
    @required this.width,
  }) : super(key: key);

  final int minValue;
  final int maxValue;
  final double width;

  int _indexToValue(int index) => minValue + (index - 1);

  @override
  build(BuildContext context) {
    int itemCount = (maxValue - minValue) + 3;
    return new ListView.builder(
      scrollDirection: Axis.horizontal,
      itemExtent: width / 3,
      itemCount: itemCount,
      physics: BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        final int value = _indexToValue(index);
        bool isExtra = index == 0 || index == itemCount - 1;
        return isExtra ? new Container()
         : Center(
              child: new Text(
                value.toString(),
                style: WEIGHT_TEXT_STYLE,
          ),
        );
      },
    );
  }

}