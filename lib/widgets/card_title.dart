import 'package:bmi_calculator/widgets/bmi_theme.dart';
import 'package:flutter/material.dart';

class CardTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const CardTitle(this.title, {Key key, this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: title,
        style: TITLE_STYLE,
        children: <TextSpan>[
          TextSpan(
            text: subtitle ?? "",
            style: SUBTITLE_STYLE,
          ),
        ],
      ),
    );
  }
}
