import 'package:flutter/material.dart';
import 'package:flutter_practice/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To Do',
      home: HomePage(),
      theme: ThemeData.light(),
    );
  }
}