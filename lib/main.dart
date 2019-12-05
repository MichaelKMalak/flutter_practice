import 'package:async_redux/async_redux.dart';
import 'package:bmi_calculator/logic/bmi_connector.dart';
import 'package:bmi_calculator/logic/name_connector.dart';
import 'package:bmi_calculator/logic/result_connector.dart';
import 'package:bmi_calculator/model/state.dart';
import 'package:bmi_calculator/strings/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Store<AppState> store;

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  NavigateAction.setNavigatorKey(navigatorKey);
  var state = AppState.initialState();
  store = Store<AppState>(initialState: state);
  runApp(MyApp());
}


final routes = {
  '/': (BuildContext context) => NameConnector(),
  "/bmiPage": (BuildContext context) => BmiConnector(),
  "/resultPage": (BuildContext context) => ResultConnector(),
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
      ),
    );
  }
}

