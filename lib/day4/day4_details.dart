import 'dart:math';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/material.dart';

class DetailsOfDay4 extends StatefulWidget {
  const DetailsOfDay4({super.key});

  @override
  State<DetailsOfDay4> createState() => _DetailsOfDay4State();
}

class _DetailsOfDay4State extends State<DetailsOfDay4> {
  bool seeAllGridView = false;
  List<Image> networkList = [
    Image.network(
        'https://topsoccerblog.com/wp-content/uploads/2022/12/gettyimages-1432828736-612x612-1.jpg'),
    Image.network(
        'https://topsoccerblog.com/wp-content/uploads/2022/11/gettyimages-1244726450-612x612-1.jpg'),
    Image.network(
        'https://www.kreedon.com/wp-content/uploads/2021/10/Zinedine-Zidane-France.jpg.webp'),
    Image.network(
        'https://media.cnn.com/api/v1/images/stellar/prod/230103180432-eriksen-world-cup.jpg?c=original'),
    Image.network(
        'https://fifpro.org/media/5chb3dva/lionel-messi_imago1019567000h.jpg?anchor=center&mode=crop&rnd=133202937611530000'),
    Image.network(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDK4bDxWBw4-PqszQSmmArSbIgR2D3Yjjn9Q&usqp=CAU'),
    Image.network(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsGZDAIKJ4bYO85zsQOxyMSrrCKJZhndMRKA&usqp=CAU'),
    Image.network(
        'https://images.sportsbrief.com/images/1120/68d8dc2baca7d3f2.jpeg?v=1'),
    Image.network(
        'https://media.tatler.com/photos/6141e93ec7c750ce9964d1a6/master/w_320%2Cc_limit/gettyimages-1324079216.jpg'),
    Image.network(
        'https://images2.minutemediacdn.com/image/upload/c_fill,w_720,ar_16:9,f_auto,q_auto,g_auto/shape/cover/sport/AC-Milan-v-AS-Roma---Serie-A-a2c6966780088955a76382abc4cda565.jpg')
  ];

  List<String> randomtext = [
    'Neymar',
    'Zidane',
    'Rashford',
    'Thiago_Silva',
    'Lewandwoski',
    'Eriksen',
    'Zlatan'
        'Bellingham',
    'Messi',
    'Ronaldo'
  ];

  List<Color> colorList = [
    const Color.fromARGB(255, 74, 16, 12),
    const Color.fromARGB(255, 8, 48, 81),
    Colors.green,
    const Color.fromARGB(255, 68, 62, 3),
    const Color.fromARGB(255, 73, 46, 6),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropShadow(
            borderRadius: 20,
            child: Container(
                width: double.infinity,
                // ignore: prefer_const_constructors
                color: Color.fromARGB(255, 153, 20, 111),
                height: 50,
                child: const Column(
                  children: [
                    Text('Title : Some Great Players'),
                    Text('Subtitle: With Great Footballing Techniques'),
                    Text('Date: 2080-04-06'),
                  ],
                ))),
        SizedBox(
          height: 280,
          child: Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    mainAxisExtent: 140),
                itemCount: seeAllGridView ? 20 : 10,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: colorList[index % colorList.length]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 100,
                            width: double.infinity,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15)),
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: networkList[
                                    Random().nextInt(networkList.length)],
                              ),
                            ),
                          ),
                          const Divider(height: 10),
                          Text(
                              "Title:  ${randomtext[Random().nextInt(randomtext.length)]}")
                        ],
                      ));
                },
              ),
            ),
          ),
        ),
        ElevatedButton(
            onPressed: () {
              setState(() {
                seeAllGridView = !seeAllGridView;
              });
            },
            child: Text(!seeAllGridView ? 'See More' : 'See Less')),
        const SizedBox(height: 10),
        const Divider(
          thickness: 10,
          color: Colors.black,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.count(
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 3,
              children: <Widget>[
                Container(
                  color: const Color.fromARGB(255, 173, 23, 23),
                  // height: 20,
                ),
                Container(
                  color: const Color.fromARGB(255, 75, 68, 5),
                  // height: 20,
                ),
                Container(
                  color: const Color.fromARGB(255, 5, 45, 70),
                  // height: 20,
                ),
                Container(
                  color: const Color.fromARGB(255, 23, 14, 93),
                  // height: 20,
                ),
                Container(
                  color: const Color.fromARGB(255, 6, 117, 69),
                  // height: 20,
                ),
                Container(
                  color: const Color.fromARGB(255, 132, 59, 16),
                  // height: 20,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
