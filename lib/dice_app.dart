import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  return runApp(const DiceApp());
}

class DiceApp extends StatelessWidget {
  const DiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: DicePage(
        title: 'Dice App',
      ),
    );
  }
}

class DicePage extends StatefulWidget {
  final String title;

  const DicePage({
    super.key,
    required this.title,
  });

  @override
  State<DicePage> createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  int _currentLeft = 1;
  int _currentRight = 2;

  void _refreshLeft() {
    setState(() {
      _currentLeft = Random().nextInt(6) + 1;
    });
  }

  void _refreshRight() {
    setState(() {
      _currentRight = Random().nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextButton(
                  onPressed: _refreshLeft,
                  child: Image(
                    image: AssetImage(
                      'images/dice$_currentLeft.png',
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextButton(
                  onPressed: _refreshRight,
                  child: Image(
                    image: AssetImage(
                      'images/dice$_currentRight.png',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
