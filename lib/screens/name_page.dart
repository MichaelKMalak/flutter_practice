import 'package:bmi_calculator/model/state.dart';
import 'package:bmi_calculator/strings/text.dart';
import 'package:bmi_calculator/widgets/utils.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../widgets/utils.dart';


class NamePage extends StatefulWidget {
  final VoidCallback onChangePage;

  const NamePage({Key key, this.onChangePage})
      : assert(onChangePage != null),
        super(key: key);

  @override
  _NamePageState createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
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
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Txt(WHAT_IS_YOUR_NAME_TXT, style: cardTitleStyle),
            Txt('',
                style: editableStyle(context)
                  ..editable(
                    placeholder: "",
                    maxLines: 1,
                    onEditingComplete: () {
                      if (_name.isNotEmpty) {
                        AppState().name = _name;
                        print("the saved name is ${AppState().name}");
                        widget.onChangePage();
                      }
                    },
                    onChange: (newName) => setState(() => _name = newName),
                  )),
          ]),
    );
  }

}
