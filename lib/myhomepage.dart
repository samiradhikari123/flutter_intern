import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isclicked = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        setState(() {
          _isclicked = !_isclicked;
        });
      },
      child: Text(
        _isclicked ? 'Clicked' : 'Click Me',
        style: TextStyle(
          color: _isclicked ? Colors.green : Colors.black,
        ),
      ),
    );
  }
}
