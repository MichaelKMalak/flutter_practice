import 'package:bmi_calculator/strings/text.dart';
import 'package:bmi_calculator/widgets/utils.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../widgets/utils.dart';

class NamePage extends StatefulWidget {
  final VoidCallback onChangePage;
  final ValueChanged<String> onSaveName;

  NamePage({Key key, this.onChangePage, this.onSaveName})
      : assert(onChangePage != null),
        super(key: key);

  @override
  _NamePageState createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
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
                    maxLines: 1,
                    onEditingComplete: () {
                      widget.onChangePage();
                    },
                    onChange: (newName) =>
                        setState(() => widget.onSaveName(newName)),
                  )),
          ]),
    );
  }
}
