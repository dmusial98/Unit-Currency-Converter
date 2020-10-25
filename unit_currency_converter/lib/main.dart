import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Padding(
            padding:
                EdgeInsets.only(left: 0.0, right: 0.0, top: 50.0, bottom: 0.0),
            child: Column(children: [
              Container(
                child: Row(
                  textDirection: TextDirection.ltr,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text("JEDNOSTKI",
                            textDirection: TextDirection.ltr, style: textStyle)
                      ],
                    ),
                    Column(children: [
                      Text("WALUTY",
                          textDirection: TextDirection.ltr, style: textStyle)
                    ])
                  ],
                ),
              ),
              Container(
                child: Row(
                    textDirection: TextDirection.ltr,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Masa",
                              textDirection: TextDirection.ltr,
                              style: textStyle)
                        ],
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Długość",
                                textDirection: TextDirection.ltr,
                                style: textStyle)
                          ])
                    ]),
              ),
              Container(
                  child: ListView(scrollDirection: Axis.vertical, padding: const EdgeInsets.all(8), children: <Widget>[

                    // children: <Widget>[
                      Container(
                        height: 50,
                        color: Colors.amber[600],
                        child: const Center(child: Text('Entry A')),
                      ),
                      Container(
                        height: 50,
                        color: Colors.amber[500],
                        child: const Center(child: Text('Entry B')),
                      ),
                      Container(
                        height: 50,
                        color: Colors.amber[100],
                        child: const Center(child: Text('Entry C')),
                      ),
                    // ],
                // Container(
                //     child: ListTile(title: Text("Pozycja 2",
                //               textDirection: TextDirection.ltr, style: textStyle2) ),
                // Container(
                //     child: Text("Pozycja 2",
                //         textDirection: TextDirection.ltr, style: textStyle2)),
                // Container(
                //     child: Text("Pozycja 3",
                //         textDirection: TextDirection.ltr, style: textStyle2)),
                // Container(
                //     child: Text("Pozycja 4",
                //         textDirection: TextDirection.ltr, style: textStyle2)),
                // Container(
                //     child: Text("Pozycja 5",
                //         textDirection: TextDirection.ltr, style: textStyle2)),
                // Container(
                //     child: Text("Pozycja 6",
                //         textDirection: TextDirection.ltr, style: textStyle2)),
                // Container(
                //     child: Text("Pozycja 7",
                //         textDirection: TextDirection.ltr, style: textStyle2)),
                // Container(
                //     child: Text("Pozycja 8",
                //         textDirection: TextDirection.ltr, style: textStyle2)),
                // Container(
                //     child: Text("Pozycja 9",
                //         textDirection: TextDirection.ltr, style: textStyle2)),
                // Container(
                //     child: Text("Pozycja 10",
                //         textDirection: TextDirection.ltr, style: textStyle2)),
                // Container(
                //     child: Text("Pozycja 11",
                //         textDirection: TextDirection.ltr, style: textStyle2)),
                // Container(
                //     child: Text("Pozycja 12",
                //         textDirection: TextDirection.ltr, style: textStyle2)),
                // Container(
                //     child: Text("Pozycja 13",
                //         textDirection: TextDirection.ltr, style: textStyle2)),
                // Container(
                //     child: Text("Pozycja 14",
                //         textDirection: TextDirection.ltr, style: textStyle2)),
                // Container(
                //     child: Text("Pozycja 15",
                //         textDirection: TextDirection.ltr, style: textStyle2)),
                // Container(
                //     child: Text("Pozycja 16",
                //         textDirection: TextDirection.ltr, style: textStyle2)),
                // Container(
                //     child: Text("Pozycja 17",
                //         textDirection: TextDirection.ltr, style: textStyle2)),
                // Container(
                //     child: Text("Pozycja 18",
                //         textDirection: TextDirection.ltr, style: textStyle2)),
                // Container(
                //     child: Text("Pozycja 19",
                //         textDirection: TextDirection.ltr, style: textStyle2)),
                // Container(
                //     child: Text("Pozycja 20",
                //         textDirection: TextDirection.ltr, style: textStyle2)),
              ]))
            ])));
  }
}

var textStyle = TextStyle(
  fontSize: 32,
  color: Colors.black87,
);

var textStyle2 = TextStyle(fontSize: 20, color: Colors.black);
