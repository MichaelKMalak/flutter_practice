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
  int weight;

  @override
  void initState() {
    super.initState();
    weight = 70;
  }

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
                  value: weight,
                  onChanged: (val) => setState(() => weight = val),
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
    this.value,
    this.onChanged,
  }) : super(key: key);

  final int minValue;
  final int maxValue;
  final double width;

  final int value;
  final ValueChanged<int> onChanged;

  double get itemExtent => width / 3;
  int _indexToValue(int index) => minValue + (index - 1);

  @override
  build(BuildContext context) {
    int itemCount = (maxValue - minValue) + 3;
    return NotificationListener(
        onNotification: _onNotification,
        child: new ListView.builder(
      scrollDirection: Axis.horizontal,
      itemExtent: itemExtent,
      itemCount: itemCount,
      physics: BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        final int value = _indexToValue(index);
        bool isExtra = index == 0 || index == itemCount - 1;
        return isExtra
            ? new Container() //empty first and last element
            : FittedBox(
          child: Text(
            value.toString(),
            style: _getTextStyle(value),
          ),
          fit: BoxFit.scaleDown,
        );
      }
    )
    );
  }
  int _offsetToMiddleIndex(double offset) => (offset + width / 2) ~/ itemExtent;
  bool _onNotification(Notification notification) {
    if (notification is ScrollNotification) {
      int middleValue = _indexToValue(_offsetToMiddleIndex(notification.metrics.pixels));

      if (middleValue != value) {
        onChanged(middleValue);
      }
    }
    return true;
  }
  TextStyle _getTextStyle(int itemValue) {
    return itemValue == value
        ? HIGHLIGHTED_WEIGHT_TEXT_STYLE
        : WEIGHT_TEXT_STYLE;
  }
}

