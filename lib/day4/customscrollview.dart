import 'package:flutter/material.dart';

class CustomeScrollView extends StatefulWidget {
  const CustomeScrollView({super.key});

  @override
  State<CustomeScrollView> createState() => _CustomeScrollViewState();
}

class _CustomeScrollViewState extends State<CustomeScrollView> {
  bool seeAllList = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        const SliverAppBar(
            floating: false,
            pinned: true,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('This is the custom scroll view'),
            )),
        SliverList(
            delegate: SliverChildBuilderDelegate(
          childCount: 3,
          (BuildContext context, int index) {
            // for (var i = 1; i <= 10; i++)
            return Column(
              children: [
                SizedBox(
                  height: seeAllList ? 430 : 275,
                  // height: 275,
                  // color: Colors.grey,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: const EdgeInsets.fromLTRB(7, 0, 7, 9),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 26, 185, 199),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        //height: 60,
                        child: ListTile(
                          leading: const CircleAvatar(),
                          title: Text(
                              'Scroll here to see the change ${index + 1}'),
                          subtitle: const Text('Subtitle of ListTitle'),
                        ),
                      );
                    },
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        seeAllList = !seeAllList;
                      });
                    },
                    child: Text(seeAllList ? 'See Less' : 'See More'))
              ],
            );
          },
        )),
      ]),
    );
  }
}
