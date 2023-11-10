import 'package:flutter/material.dart';

void main() {
  runApp(const LayoutsApp());
}

class LayoutsApp extends StatelessWidget {
  const LayoutsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blueGrey[900],
        body: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                color: Colors.red,
                width: 100.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    color: Colors.yellow,
                    width: 100.0,
                    height: 100.0,
                  ),
                  Container(
                    color: Colors.green,
                    width: 100.0,
                    height: 100.0,
                  ),
                ],
              ),
              Container(
                color: Colors.blue,
                width: 100.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
