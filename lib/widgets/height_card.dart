import 'dart:math' as math;

import 'package:bmi_calculator/strings/text.dart';
import 'package:bmi_calculator/widgets/utils.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import 'card_title.dart';

class HeightCard extends StatelessWidget {
  final int height;
  final ValueChanged<int> onChanged;

  const HeightCard({Key key, this.height = 170, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _drawSlider() {
      final ParentStyle sliderStyle = ParentStyle()
        ..padding(bottom: screenAwareSize(8.0, context));
      return Expanded(
        child: Parent(
          style: sliderStyle,
          child: LayoutBuilder(builder: (context, constraints) {
            return HeightPicker(
              widgetHeight: constraints.maxHeight,
              height: height,
              onChange: (val) => onChanged(val),
            );
          }),
        ),
      );
    }

    final ParentStyle heightCardStyle = cardStyle
      ..add(
        ParentStyle()
          ..width(double.infinity)
          ..margin(all: 0.0, left: 5.0)
          ..padding(top: screenAwareSize(SMALL_DIM, context)),
        override: true,
      );

    return Parent(
      style: heightCardStyle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CardTitle(
            HEIGHT_TXT,
            subtitle: HEIGHT_SUBTITLE_TXT,
          ),
          _drawSlider(),
        ],
      ),
    );
  }
}

class HeightPicker extends StatefulWidget {
  final int maxHeight;
  final int minHeight;
  final int height;
  final double widgetHeight;
  final ValueChanged<int> onChange;

  const HeightPicker({Key key,
    this.height,
    this.widgetHeight,
    this.onChange,
    this.maxHeight = 220,
    this.minHeight = 120})
      : super(key: key);

  int get totalUnits => maxHeight - minHeight;

  @override
  _HeightPickerState createState() => _HeightPickerState();
}

class HeightSlider extends StatelessWidget {
  final int height;

  const HeightSlider({Key key, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SliderLabel(height: height),
          Row(
            children: <Widget>[
              SliderCircle(),
              Expanded(child: SliderLine()),
            ],
          ),
        ],
      ),
    );
  }
}

class SliderCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ParentStyle sliderCircleStyle = ParentStyle()
      ..width(screenAwareSize(MEDIUM_DIM, context))
      ..height(screenAwareSize(MEDIUM_DIM, context))
      ..background.color(PRIMARY_COLOR)
      ..circle();

    return Parent(
      style: sliderCircleStyle,
      child: Icon(
        Icons.unfold_more,
        color: Colors.white,
        size: 0.6 * screenAwareSize(MEDIUM_DIM, context),
      ),
    );
  }
}

class SliderLabel extends StatelessWidget {
  final int height;

  const SliderLabel({Key key, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TxtStyle highlightedTextStyle = TxtStyle()
      ..fontSize(20.0)
      ..textColor(SECONDARY_TXT_COLOR)
      ..fontWeight(FontWeight.w600);

    final ParentStyle highlightedStyle = ParentStyle()
      ..padding(
        left: screenAwareSize(4.0, context),
        bottom: screenAwareSize(2.0, context),
      );

    return Parent(
      style: highlightedStyle,
      child: Txt(
        height.toString(),
        style: highlightedTextStyle,
      ),
    );
  }
}

class SliderLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: List.generate(
          40,
              (i) =>
              Expanded(
                child: Container(
                  height: 2.0,
                  decoration: BoxDecoration(
                      color: i.isEven
                          ? Theme
                          .of(context)
                          .primaryColor
                          : Colors.white),
                ),
              )),
    );
  }
}

class _HeightPickerState extends State<HeightPicker> {
  double _startDragYOffset;
  int _startDragHeight;
  double _labelFont = 16.0;

  double get _drawingHeight =>
      _totalHeight - (_marginBottom + _marginTop + _labelFont);

  double get _marginBottom => screenAwareSize(_labelFont, context);

  double get _marginTop => screenAwareSize(70.0, context);

  double get _pixelsPerUnit => _drawingHeight / widget.totalUnits;

  double get _sliderPosition =>
      _labelFont / 2 + (widget.height - widget.minHeight) * _pixelsPerUnit;

  double get _totalHeight => widget.widgetHeight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onVerticalDragStart: _onDragStart,
        onVerticalDragUpdate: _onDragUpdate,
        child: Stack(
          children: <Widget>[
            _drawSlider(),
            _drawLabels(),
          ],
        ));
  }

  Widget _drawLabels() {
    int countOfLabels = widget.totalUnits ~/ 5 + 1;
    List<Widget> labels = List.generate(
      countOfLabels,
          (i) {
        return Text(
          "${widget.maxHeight - 5 * i}",
          style: LABELS_TEXT_STYLE,
        );
      },
    );
    final ParentStyle labelsStyle = ParentStyle()
      ..alignment.centerRight()
      ..padding(
          right: screenAwareSize(SMALL_DIM, context),
          bottom: screenAwareSize(SMALL_DIM, context),
          top: screenAwareSize(SMALL_DIM, context));

    return Parent(
      style: labelsStyle,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: labels,
      ),
    );
  }

  Widget _drawSlider() {
    return Positioned(
      child: HeightSlider(height: widget.height),
      left: 0.0,
      right: 0.0,
      bottom: _sliderPosition,
    );
  }

  int _globalOffsetToHeight(Offset globalOffset) {
    RenderBox getBox = context.findRenderObject();
    Offset localPosition = getBox.globalToLocal(globalOffset);
    double dy = localPosition.dy;
    dy = dy - _marginTop - _labelFont / 2;
    int height = widget.maxHeight - (dy ~/ _pixelsPerUnit);
    return height;
  }

  int _normalizeHeight(int height) =>
      math.max(widget.minHeight, math.min(widget.maxHeight, height));

  _onDragStart(DragStartDetails dragStartDetails) {
    int newHeight = _globalOffsetToHeight(dragStartDetails.globalPosition);
    widget.onChange(newHeight);
    setState(() {
      _startDragYOffset = dragStartDetails.globalPosition.dy;
      _startDragHeight = newHeight;
    });
  }

  _onDragUpdate(DragUpdateDetails dragUpdateDetails) {
    double currentYOffset = dragUpdateDetails.globalPosition.dy;
    double verticalDifference = _startDragYOffset - currentYOffset;
    int diffHeight = verticalDifference ~/ _pixelsPerUnit;
    int height = _normalizeHeight(_startDragHeight + diffHeight);
    setState(() => widget.onChange(height));
  }
}
