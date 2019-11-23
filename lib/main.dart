import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Basic Shapes',
    home: Scaffold(
      appBar: AppBar(
        title: Text('Basic Shapes'),
      ),
      body: HelloRectangle(),
    ),
  ));
}

class HelloRectangle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.black,
        height: 400.0,
        width: 400.0,
        child: Center(
          child: Container(
            height: 400.0,
            width: 400.0,
            decoration: new BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
