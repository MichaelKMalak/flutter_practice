import 'package:bmi_calculator/screens/name_page.dart';
import 'package:bmi_calculator/strings/text.dart';
import 'package:flutter/material.dart';

import 'widgets/utils.dart';


void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: BMI_CALC_TXT,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: BMI_CALC_TXT,
      theme: ThemeData(
        primarySwatch: PRIMARY_COLOR,
      ),
      home: Scaffold(
        body: NameCard(),
      ),
    );
  }
}