import 'package:bmi_calculator/strings/paths.dart';
import 'package:bmi_calculator/strings/text.dart';
import 'package:bmi_calculator/widgets/utils.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'card_title.dart';

class WeightBackground extends StatelessWidget {
  final Widget child;

  const WeightBackground({Key key, this.child}) : super(key: key);

  Widget build(BuildContext context) {
    final ParentStyle weightCardStyle = ParentStyle()
      ..height(screenAwareSize(200.0, context))
      ..background.color(Colors.grey[200])
      ..borderRadius(all: screenAwareSize(250.0, context));

    final ParentStyle weightArrowStyle = ParentStyle()
      ..height(screenAwareSize(20.0, context))
      ..width(screenAwareSize(35.0, context));

    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Parent(
          style: weightCardStyle,
          child: child,
        ),
        Parent(
          style: weightArrowStyle,
          child: SvgPicture.asset(
            WEIGHT_ARROW_SVG_PATH,
            color: PRIMARY_COLOR,
          ),
        ),
      ],
    );
  }
}

class WeightCard extends StatelessWidget {
  final int weight;
  final ValueChanged<int> onChanged;

  const WeightCard({Key key, this.weight = 70, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ParentStyle weightCardStyle = cardStyle
      ..add(
        ParentStyle()
          ..width(double.infinity)
          ..margin(all: 1.0, top: 5.0)
          ..padding(top: SMALL_DIM),
        override: true,
      );

    return Parent(
      style: weightCardStyle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CardTitle(WEIGHT_TXT, subtitle: WEIGHT_SUBTITLE_TXT),
          _drawSlider(),
        ],
      ),
    );
  }

  Widget _drawSlider() {
    return Parent(
      style: ParentStyle()
        ..alignment.center()
        ..padding(vertical: SMALL_DIM, horizontal: SMALL_DIM),
      child: WeightBackground(
        child: LayoutBuilder(
          builder: (context, constraints) =>
              WeightSlider(
                minValue: 30,
                maxValue: 200,
                width: constraints.maxWidth,
                value: weight,
                onChanged: (val) => onChanged(val),
              ),
        ),
      ),
    );
  }
}

class WeightSlider extends StatelessWidget {
  final int minValue;

  final int maxValue;
  final double width;
  final int value;

  final ValueChanged<int> onChanged;
  final TxtStyle highlightedNumbers = TxtStyle()
    ..textColor(SECONDARY_TXT_COLOR)
    ..fontSize(LARGE_FONT);

  final TxtStyle normalNumbers = TxtStyle()
    ..textColor(Color.fromRGBO(196, 197, 203, 1.0))
    ..fontSize(SMALL_FONT);

  WeightSlider({
    Key key,
    @required this.minValue,
    @required this.maxValue,
    @required this.width,
    this.value,
    this.onChanged,
  }) : super(key: key);

  double get itemExtent => width / 3;

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
                child: Txt(
                  value.toString(),
                  style: _getTextStyle(value),
                ),
                fit: BoxFit.scaleDown,
              );
            }));
  }

  TxtStyle _getTextStyle(int itemValue) {
    return itemValue == value ? highlightedNumbers : normalNumbers;
  }

  int _indexToValue(int index) => minValue + (index - 1);

  int _offsetToMiddleIndex(double offset) => (offset + width / 2) ~/ itemExtent;

  bool _onNotification(Notification notification) {
    if (notification is ScrollNotification) {
      int middleValue =
      _indexToValue(_offsetToMiddleIndex(notification.metrics.pixels));

      if (middleValue != value) {
        onChanged(middleValue);
      }
    }
    return true;
  }
}
