import 'package:flutter/material.dart';
import 'day3/screens.dart';

void main() {
  runApp(const Day3());
}

class Day3 extends StatelessWidget {
  const Day3({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Screens(),
    );
  }
}
