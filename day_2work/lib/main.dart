import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Text Button',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RandomTextButton(),
    );
  }
}

class RandomTextButton extends StatefulWidget {
  @override
  _RandomTextButtonState createState() => _RandomTextButtonState();
}

class _RandomTextButtonState extends State<RandomTextButton> {
  Color _buttonColor = Colors.blue;
  Color _textColor = Colors.white;
  double _fontSize = 16.0;

  void changeProperties() {
    setState(() {
      // Generate random values for properties
      _buttonColor = _getRandomColor();
      _textColor = _getRandomColor();
      _fontSize = Random().nextInt(21).toDouble() + 10.0;
    });
  }

  Color _getRandomColor() {
    List<Color> colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.yellow,
    ];
    return colors[Random().nextInt(colors.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Text Button'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Text Widget',
              style: TextStyle(
                color: _textColor,
                fontSize: _fontSize,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: changeProperties,
              child: Text(
                'Button',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(_buttonColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
