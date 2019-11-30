import 'package:bmi_calculator/screens/GetNamePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'widgets/utils.dart';
import 'package:bmi_calculator/strings/text.dart';


void main() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(new MyApp()));
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