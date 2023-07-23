import 'package:flutter/material.dart';

import '../day3/screens.dart';
import '../myhomepage.dart';
import 'customscrollview.dart';
import 'day4_details.dart';

class Day4Screen extends StatefulWidget {
  const Day4Screen({super.key});

  @override
  State<Day4Screen> createState() => _Day4ScreenState();
}

class _Day4ScreenState extends State<Day4Screen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(" Assigment_4"),
          centerTitle: true,
          leading: const Icon(Icons.sunny),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CustomeScrollView()));
                },
                icon: const Icon(Icons.near_me_outlined))
          ],
          bottom: TabBar(
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), color: Colors.grey),
              indicatorColor: Colors.amber,
              // indicatorSize: TabBarIndicatorSize.label,
              tabs: const [
                Tab(
                    icon: Icon(Icons.home,
                        color: Color.fromARGB(255, 76, 18, 193)),
                    child: Text("Day_2_Tab")),
                Tab(
                    icon: Icon(Icons.settings,
                        color: Color.fromARGB(255, 10, 128, 16)),
                    child: Text("Day_3_Tab")),
                Tab(
                    icon: Icon(Icons.newspaper,
                        color: Color.fromARGB(255, 244, 54, 54)),
                    child: Text("Day_4_Tab")),
              ]),
        ),
        body: const TabBarView(children: [
          MyHomePage(),
          Screens(),
          DetailsOfDay4(),
        ]),
      ),
    );
  }
}
