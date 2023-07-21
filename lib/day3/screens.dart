import 'package:flutter/material.dart';

import 'list.dart';

class Screens extends StatefulWidget {
  const Screens({super.key});

  @override
  State<Screens> createState() => _ScreensState();
}

class _ScreensState extends State<Screens> {
  bool seeAll = false;
  bool seeAllText = false;
  final List<Map<String, dynamic>> items = [
    {
      'image': 'assets/photos/a1.jpg',
      'dateTime': '2080-03-22',
    },
    {
      'image': 'assets/photos/a2.jpg',
      'dateTime': '2080-03-22',
    },
    {
      'image': 'assets/photos/a3.jpg',
      'dateTime': '2080-03-22',
    },
    {
      'image': 'assets/photos/a4.jpg',
      'dateTime': '2080-03-22',
    },
    {
      'image': 'assets/photos/a5.jpg',
      'dateTime': '2080-03-22',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Day3"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 138,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: 100,
                      height: 100,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            FittedBox(
                              child: Image.asset(
                                items[index]['image'],
                                fit: BoxFit.cover,
                                height: 90,
                                width: 90,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "items $index",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Text(
                              items[index]['dateTime'],
                              style: const TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                              ),
                            )
                          ]),
                    );
                  }),
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: [
                const Text("Scroll View"),
                const Text("This is the scroll view"),
                SizedBox(
                  height: 350,
                  child: ListView.builder(
                      itemCount: seeAll ? url.length : 5,
                      itemBuilder: (BuildContext, int) {
                        return Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Container(
                            // height: 80,
                            color: Colors.grey,
                            child: ListTile(
                              leading: Image.network(
                                url[int],
                                fit: BoxFit.cover,
                                // height: 150,
                                width: 120,
                              ),
                              title: Text('Title ${int + 1}'),
                              subtitle:
                                  Text("Descriptoin of image  ${int + 1}"),
                              trailing: ElevatedButton(
                                onPressed: () {},
                                child: const Text("click"),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        seeAll = !seeAll;
                      });
                    },
                    child: Text(seeAll ? "Show Less" : "Show More")),
                Wrap(
                  children: [
                    Text("Hey Jude!"),
                    for (int i = 0; i < (seeAllText ? text.length : 5); i++)
                      Text(text[i]),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            seeAllText = !seeAllText;
                          });
                        },
                        child: Text(seeAllText ? 'See Less' : 'See More'))
                  ],
                )
              ],
            ),
          ],
        ));
  }
}
