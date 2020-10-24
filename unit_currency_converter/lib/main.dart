import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Padding(
            padding: EdgeInsets.only(left:0.0, right: 0.0, top: 50.0, bottom: 0.0),
            child: Column(children: [
              Container(
                child: Row(
                  textDirection: TextDirection.ltr,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                        child: Column(
                      children: [
                        Text("JEDNOSTKI",
                            textDirection: TextDirection.ltr, style: textStyle)
                      ],
                    )),
                    Column(children: [
                      Text("WALUTY",
                          textDirection: TextDirection.ltr, style: textStyle)
                    ])
                  ],
                ),
              ),
              Row(textDirection: TextDirection.ltr, children: [
                // Padding(
                //     child:
                  Row(
                        textDirection: TextDirection.ltr,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(
                            children: [
                              Text("Masa",
                                  textDirection: TextDirection.ltr,
                                  style: textStyle)
                            ],
                          ),
                          Column(children: [
                            Text("Długość",
                                textDirection: TextDirection.ltr,
                                style: textStyle)
                          ])
                        ]),
              ])
            ])));
  }
}

var textStyle = TextStyle(
  fontSize: 32,
  color: Colors.black87,
);
