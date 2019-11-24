import 'package:flutter/material.dart';
import 'package:flutter_practice/BMItheme.dart';

class BmiPage extends StatefulWidget {
  @override
  _BmiPageState createState() => _BmiPageState();
}

class _BmiPageState extends State<BmiPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: PRIMARY_COLOR,
        child: Column(children: <Widget>[
          AppBar(
            title: Text("BMI Calculator"),
            //elevation: 0,
            backgroundColor: Colors.transparent,
          ),

          // Male vs Female Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  height: MediaQuery.of(context).size.height * 0.25,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: PRIMARY_COLOR
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset('images/male.png',height: 100.0,width: 100.0,),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text('MALE',style: HEADLINE_STYLE)
                    ],
                  ),

                ),
              ),

              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  height: MediaQuery.of(context).size.height * 0.25,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: PRIMARY_COLOR
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset('images/female.png',height: 100.0,width: 100.0,),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text('FEMALE',style: HEADLINE_STYLE)
                    ],
                  ),
                ),
              )
            ],
          ),

        ]));
  }
}
