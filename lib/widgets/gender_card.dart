import 'dart:math' as math;

import 'package:bmi_calculator/model/gender.dart';
import 'package:bmi_calculator/strings/paths.dart';
import 'package:bmi_calculator/strings/text.dart';
import 'package:bmi_calculator/widgets/card_title.dart';
import 'package:bmi_calculator/widgets/utils.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

//constants
const double _DEFAULT_ANGLE = math.pi / 4;

const Map<Gender, String> _GENDER_SVG = {
  Gender.female: FEMALE_SVG_PATH,
  Gender.other: OTHER_SVG_PATH,
  Gender.male: MALE_SVG_PATH,
};
const Map<Gender, double> _genderAngle = {
  Gender.female: -_DEFAULT_ANGLE,
  Gender.other: 0.0,
  Gender.male: _DEFAULT_ANGLE,
};

double _circleRadius(BuildContext context) => screenAwareSize(170, context);

//UI components
class DrawArrow extends AnimatedWidget {
  const DrawArrow({Key key, Listenable listenable})
      : super(key: key, listenable: listenable);

  @override
  Widget build(BuildContext context) {
    Animation animation = listenable;

    return Transform.rotate(
      angle: animation.value,
      child: Transform.translate(
        offset: Offset(0.0, _translationOffset(context)),
        child: Transform.rotate(
          angle: -_DEFAULT_ANGLE,
          child: SvgPicture.asset(
            GENDER_ARROW_SVG_PATH,
            height: _arrowLength(context),
            width: _arrowLength(context),
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  double _arrowLength(BuildContext context) => screenAwareSize(70.0, context);

  double _translationOffset(BuildContext context) =>
      _arrowLength(context) * -0.4;
}

class DrawCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Parent(
      style: ParentStyle()
        ..alignment.center()
        ..background.color(PRIMARY_COLOR)
        ..height(_circleRadius(context))
        ..circle(),
    );
  }
}

class DrawGenderIcon extends StatelessWidget {
  final Gender gender;

  const DrawGenderIcon({Key key, this.gender}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _iconSize = gender == Gender.other ? 60.0 : 50.0;

    final genderAngle =
    gender == Gender.female ? -_genderAngle[gender] : _genderAngle[gender];

    final ParentStyle rotateTheIcon = ParentStyle()
      ..padding(left: screenAwareSize(SMALL_DIM, context))
      ..height(screenAwareSize(_iconSize, context))
      ..width(screenAwareSize(_iconSize, context))
      ..rotate(genderAngle);

    final ParentStyle centerTheShape = ParentStyle()
      ..padding(bottom: _circleRadius(context) / 2);

    Widget rotatedIcon = Parent(
      style: rotateTheIcon,
      child: SvgPicture.asset(_GENDER_SVG[gender]),
    );

    Widget iconWithALine = Parent(
      style: centerTheShape,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          rotatedIcon,
          GenderLine(),
        ],
      ),
    );

    Widget rotatedIconWithALine = Transform.rotate(
      alignment: Alignment.bottomCenter,
      angle: _genderAngle[gender],
      child: iconWithALine,
    );

    return Parent(
      style: centerTheShape,
      child: rotatedIconWithALine,
    );
  }
}

class GenderCard extends StatefulWidget {
  final Gender gender;
  final ValueChanged<Gender> onChanged;

  const GenderCard({
    Key key,
    this.gender = Gender.other,
    this.onChanged,
  }) : super(key: key);

  @override
  _GenderCardState createState() => _GenderCardState();
}

class GenderLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ParentStyle genderLineStyle = ParentStyle()
      ..padding(
          bottom: screenAwareSize(6.0, context),
          top: screenAwareSize(8.0, context))
      ..height(screenAwareSize(8.0, context))
      ..width(1.0)
      ..background.color(PRIMARY_COLOR);

    return Parent(
      style: genderLineStyle,
    );
  }
}

//Interactivity
class TapHandler extends StatelessWidget {
  final Function(Gender) onGenderTapped;

  const TapHandler({Key key, this.onGenderTapped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
            child: GestureDetector(onTap: () => onGenderTapped(Gender.female))),
        Expanded(
            child: GestureDetector(onTap: () => onGenderTapped(Gender.other))),
        Expanded(
            child: GestureDetector(onTap: () => onGenderTapped(Gender.male))),
      ],
    );
  }
}

class _GenderCardState extends State<GenderCard>
    with SingleTickerProviderStateMixin {
  Gender selectedGender;
  AnimationController _arrowAnimationController;

  @override
  Widget build(BuildContext context) {
    final ParentStyle genderCardStyle = cardStyle
      ..add(
        ParentStyle()
          ..margin(all: 0.0)
          ..padding(horizontal: SMALL_DIM, vertical: SMALL_DIM),
        override: true,
      );

    return Parent(
      style: genderCardStyle,
      child: Column(
        children: <Widget>[
          CardTitle(GENDER_TXT),
          Parent(
            style: ParentStyle()
              ..padding(top: 25.0),
            child: _drawMainStack(),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _arrowAnimationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    selectedGender = widget.gender ?? Gender.other;
    _arrowAnimationController = new AnimationController(
      vsync: this,
      lowerBound: -_DEFAULT_ANGLE,
      upperBound: _DEFAULT_ANGLE,
      value: _genderAngle[selectedGender],
    );
    super.initState();
  }

  Widget _addGestureDetector() {
    return Positioned.fill(
      child: TapHandler(
        onGenderTapped: _setSelectedGender,
      ),
    );
  }

  Widget _drawCircleWithArrow() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        DrawCircle(),
        DrawArrow(listenable: _arrowAnimationController),
      ],
    );
  }

  Widget _drawMainStack() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        _drawCircleWithArrow(),
        DrawGenderIcon(gender: Gender.female),
        DrawGenderIcon(gender: Gender.other),
        DrawGenderIcon(gender: Gender.male),
        _addGestureDetector(),
      ],
    );
  }

  void _setSelectedGender(Gender gender) {
    widget.onChanged(gender);
    _arrowAnimationController.animateTo(
      _genderAngle[gender],
      duration: Duration(milliseconds: 150),
    );
  }
}
