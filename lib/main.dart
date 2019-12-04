import 'package:async_redux/async_redux.dart';
import 'package:bmi_calculator/logic/bmi_connector.dart';
import 'package:bmi_calculator/logic/name_connector.dart';
import 'package:bmi_calculator/model/state.dart';
import 'package:bmi_calculator/screens/name_page.dart';
import 'package:bmi_calculator/screens/result_page.dart';
import 'package:bmi_calculator/strings/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'widgets/utils.dart';

Store<AppState> store;

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  NavigateAction.setNavigatorKey(navigatorKey);
  store = Store<AppState>(initialState: AppState());
  runApp(MyApp());
}


final routes = {
  '/': (BuildContext context) => NameConnector(),
  "/bmiPage": (BuildContext context) => BmiConnector(),
  "/resultPage": (BuildContext context) => ResultPage(),
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: BMI_CALC_TXT,
        routes: routes,
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        home: HomePage(),
      ),
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
        body: NamePage(),
      ),
    );
  }
}

