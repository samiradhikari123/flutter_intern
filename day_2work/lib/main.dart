import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyHomepage',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomepage(),
    );
  }
}

class MyHomepage extends StatefulWidget {
  @override
  _MyHomepageState createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
  Color _buttonColor = Colors.blue;
  Color _textColor = Colors.black;
  double _fontSize = 16.0;
  Color _textbuttonColor = Colors.black;

  void changeProperties() {
    setState(() {
      // Generate random values for properties
      _buttonColor = _getRandomColor();
      _textColor = _getRandomColor();
      _fontSize = Random().nextInt(21).toDouble() + 10.0;
    });
  }

  void changeColor() {
    setState(() {
      _textbuttonColor = _getRandomColor();
    });
  }

  int count = 0;
  List<Icon> iconList = [
    Icon(Icons.account_balance_outlined),
    Icon(Icons.alarm_add),
    Icon(Icons.soap_outlined),
    Icon(Icons.media_bluetooth_off),
    Icon(Icons.headphones)
  ];
  List<Image> networkList = [
    Image.network(
        'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fstatic.pexels.com%2Fphotos%2F63764%2Fpexels-photo-63764.jpeg&f=1&nofb=1&ipt=ad3ad94f8d25c20c709bc46c4f7779101c4414b1fc24528c55f228dfb57f50d4&ipo=images'),
    Image.network('https://wallpapercave.com/wp/wp8030431.jpg'),
    Image.network(
        'https://external-content.duckduckgo.com/iu/?u=http%3A%2F%2Fwallpapercave.com%2Fwp%2Fwp1882082.jpg&f=1&nofb=1&ipt=1ab14dfc4663924e2aff1c05bd59cbf1aa59920a82c89689f7dedfc113afa694&ipo=images'),
    Image.network(
        'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwallpaperheart.com%2Fwp-content%2Fuploads%2F2018%2F08%2Fbike-wallpaper-12.jpg&f=1&nofb=1&ipt=5bb75ad76f686117075a184af1c9ac03793106b11d8028236b1bc71f56c2abb0&ipo=images'),
    Image.network(
        'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fi.ytimg.com%2Fvi%2Fb84W3hAu02Q%2Fmaxresdefault.jpg&f=1&nofb=1&ipt=dd4039911525bae91d5859ccbb0e677966f0119dec0804bf072e76f348d0b519&ipo=images')
  ];
  Image imageUrl = Image.network(
      'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.wallpaperup.com%2Fuploads%2Fwallpapers%2F2015%2F07%2F03%2F741745%2F2f09e4a0a7fb09aeacc5a0b82eb9f0a9.jpg&f=1&nofb=1&ipt=bd4f5b1635c9f550f58b4d1e6bac249ce227babd2253d4322ff0359292718b31&ipo=images');

  Icon iconimage = const Icon(Icons.near_me_disabled);
  Color _getRandomColor() {
    List<Color> colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.yellow,
    ];
    return colors[Random().nextInt(colors.length)];
  }

  void changeIcons() {
    setState(() {
      iconimage = _getRandomIcon();
      imageUrl = _getRandomImage();
    });
  }

  Image _getRandomImage() {
    return networkList[Random().nextInt(networkList.length)];
  }

  Icon _getRandomIcon() {
    return iconList[Random().nextInt(iconList.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyHomePage'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            count++;
          });
        },
        child: Icon(Icons.add),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(count.toString()),
            SizedBox(
              height: 10,
            ),
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
            TextButton(
                onPressed: changeColor,
                child: Text(
                  'textbutton',
                  style: TextStyle(
                    color: _textbuttonColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            const SizedBox(height: 15),
            IconButton(
              onPressed: changeIcons,
              icon: iconimage,
              color: Colors.red,
            ),
            const SizedBox(height: 10),
            Container(
              height: 300,
              width: 400,
              color: Colors.grey,
              child: imageUrl,
            )
          ],
        ),
      ),
    );
  }
}
