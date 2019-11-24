import 'package:flutter/material.dart';
import 'package:flutter_practice/BMItheme.dart';
import 'utils.dart' show screenAwareSize;

class BmiPage extends StatefulWidget {
  @override
  _BmiPageState createState() => _BmiPageState();
}

class _BmiPageState extends State<BmiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildTitle(context),
            Expanded(child: _buildCards(context)),
            _buildBottom(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle (BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: SMALL_PADDING,
        top: screenAwareSize(MEDUIM_PADDING, context),
      ),
      child: Center(child:Text(
        "BMI Calculator",
        style: NUMBER_STYLE,
      )),
    );
  }
  Widget _buildBottom (BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: screenAwareSize(LARGE_PADDING, context),
      width: double.infinity,
      child: Switch(value: true, onChanged: (val) {}),
    );
  }
  Widget _buildCards(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: SMALL_PADDING,
        right: SMALL_PADDING,
        top: screenAwareSize(SMALL_PADDING, context),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Expanded(child: _tempCard("Gender")),
                Expanded(child: _tempCard("Weight")),
              ],
            ),
          ),
          Expanded(child: _tempCard("Height"))
        ],
      ),
    );
  }

  Widget _tempCard(String label) {
    return Card(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Text(label),
      ),
    );
  }
}
