import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() => runApp(const XylophoneApp());

class XylophoneApp extends StatelessWidget {
  const XylophoneApp({super.key});

  void _playSound(int soundNumber) {
    final player = AudioPlayer();
    player.play(AssetSource('note$soundNumber.wav'));
  }

  Expanded _buildKey({required Color color, required int soundNumber}) {
    return Expanded(
      child: TextButton(
        onPressed: () => _playSound(soundNumber),
        style: TextButton.styleFrom(
          backgroundColor: color,
        ),
        child: const Text(''),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildKey(color: Colors.red, soundNumber: 1),
              _buildKey(color: Colors.orange, soundNumber: 2),
              _buildKey(color: Colors.yellow, soundNumber: 3),
              _buildKey(color: Colors.green, soundNumber: 4),
              _buildKey(color: Colors.teal, soundNumber: 5),
              _buildKey(color: Colors.blue, soundNumber: 6),
              _buildKey(color: Colors.purple, soundNumber: 7),
              _buildKey(color: Colors.pink, soundNumber: 8),
            ],
          ),
        ),
      ),
    );
  }
}
