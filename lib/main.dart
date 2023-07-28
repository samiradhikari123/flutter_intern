import 'package:flutter/material.dart';
import 'package:intern1/day_6.dart/day_6home.dart';

void main() {
  runApp(const Day3());
}

class Day3 extends StatelessWidget {
  const Day3({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Day6(),
    );
  }
}
