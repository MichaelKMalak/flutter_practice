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
            child: Column(
              children: <Widget>[
                Container(
                  height: 150.0,
                  width: 150.0,
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                ),

                Row(
                  children: <Widget>[
                    Container(
                      height: 100.0,
                      width: 100.0,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.greenAccent,
                      ),
                    ),
                    Container(
                      height: 100.0,
                      width: 100.0,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blueAccent,
                      ),
                    ),
                    Container(
                      height: 100.0,
                      width: 200.0,
                      color: Colors.black,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
