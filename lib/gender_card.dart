import 'package:flutter/material.dart';
import 'package:bmi_calculator/BMItheme.dart';
import 'package:bmi_calculator/gender.dart';
import 'package:bmi_calculator/card_title.dart';
import 'package:bmi_calculator/utils.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

//constants
double circleRadius(BuildContext context) => screenAwareSize(170, context);
const double _DEFAULT_ANGLE = math.pi / 4;
const Map<Gender, double> _genderAngle = {
  Gender.female: -_DEFAULT_ANGLE,
  Gender.other: 0.0,
  Gender.male: _DEFAULT_ANGLE,
};
const Map<Gender, String> _GENDER_SVG = {
  Gender.female: "images/gender_female.svg",
  Gender.other: "images/gender_other.svg",
  Gender.male: "images/gender_male.svg",
};

//UI components
class GenderCard extends StatefulWidget {
  final Gender gender;
  const GenderCard({Key key, this.gender}) : super(key: key);
  @override
  _GenderCardState createState() => _GenderCardState();
}

class _GenderCardState extends State<GenderCard>
    with SingleTickerProviderStateMixin {
  Gender selectedGender;
  AnimationController _arrowAnimationController;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.only(top: screenAwareSize(SMALL_PADDING, context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CardTitle("GENDER"),
              Padding(
                padding: EdgeInsets.only(
                    top: screenAwareSize(25.0, context)),
                child: _drawMainStack(),
              )
            ],
          ),
        ),
      ),
    );
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

  @override
  void dispose() {
    _arrowAnimationController.dispose();
    super.dispose();
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

  Widget _drawCircleWithArrow() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        DrawCircle(),
        DrawArrow(listenable: _arrowAnimationController),
      ],
    );
  }

  Widget _addGestureDetector() {
    return Positioned.fill(
      child: TapHandler(
        onGenderTapped: _setSelectedGender,
      ),
    );
  }

  void _setSelectedGender(Gender gender) {
    setState(() => selectedGender = gender);
    _arrowAnimationController.animateTo(
      //<--- Animate the arrow
      _genderAngle[gender],
      duration: Duration(milliseconds: 150),
    );
  }
}

class DrawCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: circleRadius(context),
          height: circleRadius(context),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: SECONDARY_COLOR,
          ),
        ),
      ],
    );
  }
}

class GenderLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: screenAwareSize(6.0, context),
        top: screenAwareSize(8.0, context),
      ),
      child: Container(
        height: screenAwareSize(8.0, context),
        width: 1.0,
        color: Colors.grey,
      ),
    );
  }
}

class DrawGenderIcon extends StatelessWidget {
  final Gender gender;
  const DrawGenderIcon({Key key, this.gender}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _iconSize = gender == Gender.other ? 50.0 : 40.0;
    final genderAngle =
        gender == Gender.female ? _genderAngle[gender] : -_genderAngle[gender];

    Widget icon = Padding(
      padding: EdgeInsets.only(left: screenAwareSize(SMALL_PADDING, context)),
      child: SvgPicture.asset(
        _GENDER_SVG[gender],
        height: screenAwareSize(_iconSize, context),
        width: screenAwareSize(_iconSize, context),
      ),
    );

    Widget rotatedIcon = Transform.rotate(
      angle: genderAngle,
      child: icon,
    );

    Widget iconWithALine = Padding(
      padding: EdgeInsets.only(bottom: circleRadius(context) / 2),
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

    Widget centeredIconWithALine = Padding(
      padding: EdgeInsets.only(bottom: circleRadius(context) / 2),
      child: rotatedIconWithALine,
    );

    return centeredIconWithALine;
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

class DrawArrow extends AnimatedWidget {
  const DrawArrow({Key key, Listenable listenable})
      : super(key: key, listenable: listenable);
  double _arrowLength(BuildContext context) => screenAwareSize(70.0, context);
  double _translationOffset(BuildContext context) =>
      _arrowLength(context) * -0.4;
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
            "images/gender_arrow.svg",
            height: _arrowLength(context),
            width: _arrowLength(context),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
