import 'package:flutter/material.dart';

import 'day4/day4_home.dart';

void main() {
  runApp(const Day3());
}

class Day3 extends StatelessWidget {
  const Day3({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Day4Screen(),
    );
  }
}
