import 'package:bmi_calculator/screens/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:bmi_calculator/widgets/utils.dart';
import '../widgets/utils.dart';
import 'package:division/division.dart';

class NameCard extends StatefulWidget {
  @override
  _NameCardState createState() => _NameCardState();
}

class _NameCardState extends State<NameCard> {
  String _name;

  final editableStyle = (BuildContext context) => TxtStyle()
    ..textColor(Colors.black)
    ..textAlign.left()
    ..maxWidth(screenAwareSize(400, context))
    ..fontSize(16)
    ..padding(horizontal: 15, vertical: 15)
    ..margin(horizontal: 50, vertical: 10)
    ..borderRadius(all: 10)
    ..alignment.center()
    ..background.color(Colors.grey[200])
    ..ripple(true, splashColor: Colors.black.withOpacity(0.1));

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Txt('What is your name?', style: cardTitleStyle),
          Txt('',
              style: editableStyle(context)
                ..editable(
                  placeholder: "",
                  onEditingComplete: () { if(_name.isNotEmpty) _pushBmiPage();},
                  onChange: (newName) => setState(() => _name = newName),
                )),
        ]);
  }

  void _pushBmiPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => BmiPage(
                name: _name,
              )),
    );
  }
}
